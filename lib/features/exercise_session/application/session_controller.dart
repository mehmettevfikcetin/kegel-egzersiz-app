import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/completion_logs.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/services/badge_service.dart';
import 'session_state.dart';

final sessionControllerProvider =
    NotifierProvider<SessionController, SessionState>(SessionController.new);

/// Drives the live exercise timer with a 1-second [Timer.periodic] tick.
///
/// The whole session is flattened into an ordered list of phase segments up
/// front (skipping zero-length phases and the trailing rest), so ticking is a
/// simple cursor walk — easy to reason about and unit-test.
class SessionController extends Notifier<SessionState> {
  Timer? _ticker;
  List<_Segment> _segments = const [];
  int _index = 0;
  bool _muted = false;

  /// Silence audio + haptic cues without stopping the timer. Held by the UI;
  /// not part of [SessionState].
  void setMuted(bool value) => _muted = value;

  @override
  SessionState build() {
    ref.onDispose(_stopTicker);
    return SessionState.idle();
  }

  /// Fetch [exerciseId] from the database and configure (but don't start) a
  /// session for it. Loading lives in the controller so the screen can drive
  /// purely off [sessionControllerProvider] without watching a separate
  /// FutureProvider (whose loading→data swap churned the element tree mid
  /// route-transition and tripped the `_dependents.isEmpty` assertion).
  /// Returns `true` if the exercise was found and loaded, `false` otherwise
  /// (so the screen can show a "not found" state instead of spinning forever).
  Future<bool> loadById(int exerciseId) async {
    final exercise =
        await ref.read(databaseProvider).programDao.exerciseById(exerciseId);
    if (exercise == null) return false;
    load(exercise, SessionType.morning);
    return true;
  }

  /// Configure (but don't start) a session for [exercise].
  void load(Exercise exercise, SessionType session) {
    _stopTicker();
    _segments = _buildSegments(exercise);
    _index = 0;
    final first = _segments.isEmpty ? null : _segments.first;
    state = SessionState(
      exercise: exercise,
      session: session,
      phase: first?.phase ?? TimerPhase.finished,
      secondsLeftInPhase: first?.seconds ?? 0,
      currentRep: first?.rep ?? 1,
      currentSet: first?.set ?? 1,
      isRunning: false,
      elapsedSeconds: 0,
    );
  }

  void start() {
    if (state.exercise == null || _segments.isEmpty) return;
    state = state.copyWith(isRunning: true);
    _cue(state.phase, vibrate: true);
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void pause() {
    _stopTicker();
    state = state.copyWith(isRunning: false);
  }

  void resume() {
    if (state.isFinished) return;
    start();
  }

  /// Jump to the next phase immediately, leaving the ticker running.
  void skip() {
    if (state.isFinished || state.exercise == null) return;
    _index++;
    if (_index >= _segments.length) {
      _finish();
      return;
    }
    final seg = _segments[_index];
    state = state.copyWith(
      phase: seg.phase,
      secondsLeftInPhase: seg.seconds,
      currentRep: seg.rep,
      currentSet: seg.set,
    );
    _cue(seg.phase, vibrate: true);
  }

  void abort() {
    _stopTicker();
    state = SessionState.idle();
  }

  void _tick() {
    final remaining = state.secondsLeftInPhase - 1;
    if (remaining > 0) {
      state = state.copyWith(
        secondsLeftInPhase: remaining,
        elapsedSeconds: state.elapsedSeconds + 1,
      );
      return;
    }

    // Current segment finished — advance.
    _index++;
    if (_index >= _segments.length) {
      _finish();
      return;
    }
    final seg = _segments[_index];
    state = state.copyWith(
      phase: seg.phase,
      secondsLeftInPhase: seg.seconds,
      currentRep: seg.rep,
      currentSet: seg.set,
      elapsedSeconds: state.elapsedSeconds + 1,
    );
    _cue(seg.phase, vibrate: true);
  }

  void _finish() {
    _stopTicker();
    state = state.copyWith(
      phase: TimerPhase.finished,
      secondsLeftInPhase: 0,
      isRunning: false,
      elapsedSeconds: state.elapsedSeconds + 1,
    );
    if (!_muted) {
      _vibrateDone();
      ref.read(audioCuesProvider).playDone();
    }
  }

  /// Persists the completed session, then re-evaluates achievements. Returns
  /// the badges that were newly unlocked by this completion (empty if none), so
  /// the UI can celebrate them.
  Future<List<Badge>> saveCompletion({String? note}) async {
    final exercise = state.exercise;
    if (exercise == null) return const [];
    final db = ref.read(databaseProvider);
    await db.completionDao.logCompletion(
      CompletionLogsCompanion(
        exerciseId: Value(exercise.id),
        weekId: Value(exercise.weekId),
        session: Value(state.session),
        holdSecondsAchieved: Value(exercise.holdSeconds),
        durationSeconds: Value(state.elapsedSeconds),
        note: Value(note),
      ),
    );
    return ref.read(badgeServiceProvider).check();
  }

  void _cue(TimerPhase phase, {bool vibrate = false}) {
    if (_muted) return;
    ref.read(audioCuesProvider).playPhase(phase);
    if (vibrate) _vibratePhase(phase);
  }

  Future<void> _vibratePhase(TimerPhase phase) async {
    // Light tap on phase change; squeeze/hold get a slightly stronger cue.
    HapticFeedback.selectionClick();
    try {
      if (await Vibration.hasVibrator()) {
        final ms = (phase == TimerPhase.squeeze || phase == TimerPhase.hold)
            ? 200
            : 80;
        Vibration.vibrate(duration: ms);
      }
    } catch (_) {/* device without vibrator */}
  }

  Future<void> _vibrateDone() async {
    HapticFeedback.heavyImpact();
    try {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(pattern: [0, 200, 100, 200, 100, 400]);
      }
    } catch (_) {}
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  /// Cancels the running ticker without emitting state — safe to call from a
  /// widget's dispose(). The next [load] starts a fresh session.
  void disposeTimer() => _stopTicker();

  static List<_Segment> _buildSegments(Exercise e) {
    final segs = <_Segment>[];
    for (var set = 1; set <= e.sets; set++) {
      for (var rep = 1; rep <= e.reps; rep++) {
        void add(TimerPhase p, int s) {
          if (s > 0) segs.add(_Segment(p, s, rep, set));
        }

        add(TimerPhase.squeeze, e.squeezeSeconds);
        add(TimerPhase.hold, e.holdSeconds);
        add(TimerPhase.release, e.releaseSeconds);
        final isLast = set == e.sets && rep == e.reps;
        if (!isLast) add(TimerPhase.rest, e.restSeconds);
      }
    }
    return segs;
  }
}

class _Segment {
  final TimerPhase phase;
  final int seconds;
  final int rep;
  final int set;
  const _Segment(this.phase, this.seconds, this.rep, this.set);
}
