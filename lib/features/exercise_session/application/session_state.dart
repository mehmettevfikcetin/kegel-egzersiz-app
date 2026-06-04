import '../../../core/database/app_database.dart';
import '../../../core/database/tables/completion_logs.dart';

/// Phases of a single rep, in order. `idle`/`finished` carry no audio cue.
enum TimerPhase { idle, squeeze, hold, release, rest, finished }

/// Immutable snapshot of the running timer, emitted by [SessionController].
class SessionState {
  final Exercise? exercise;
  final SessionType session;
  final TimerPhase phase;
  final int secondsLeftInPhase;
  final int currentRep; // 1-based
  final int currentSet; // 1-based
  final bool isRunning;
  final int elapsedSeconds;

  const SessionState({
    required this.exercise,
    required this.session,
    required this.phase,
    required this.secondsLeftInPhase,
    required this.currentRep,
    required this.currentSet,
    required this.isRunning,
    required this.elapsedSeconds,
  });

  factory SessionState.idle() => const SessionState(
        exercise: null,
        session: SessionType.morning,
        phase: TimerPhase.idle,
        secondsLeftInPhase: 0,
        currentRep: 1,
        currentSet: 1,
        isRunning: false,
        elapsedSeconds: 0,
      );

  bool get isFinished => phase == TimerPhase.finished;
  int get totalReps => exercise?.reps ?? 0;
  int get totalSets => exercise?.sets ?? 1;

  SessionState copyWith({
    Exercise? exercise,
    SessionType? session,
    TimerPhase? phase,
    int? secondsLeftInPhase,
    int? currentRep,
    int? currentSet,
    bool? isRunning,
    int? elapsedSeconds,
  }) {
    return SessionState(
      exercise: exercise ?? this.exercise,
      session: session ?? this.session,
      phase: phase ?? this.phase,
      secondsLeftInPhase: secondsLeftInPhase ?? this.secondsLeftInPhase,
      currentRep: currentRep ?? this.currentRep,
      currentSet: currentSet ?? this.currentSet,
      isRunning: isRunning ?? this.isRunning,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    );
  }
}
