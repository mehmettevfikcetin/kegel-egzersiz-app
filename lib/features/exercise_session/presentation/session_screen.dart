import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../achievements/presentation/badge_unlock_sheet.dart';
import '../application/session_controller.dart';
import '../application/session_state.dart';

/// Immersive timer: walks squeeze/hold/release/rest phases with a circular
/// countdown, vibration + audio cues, then logs the completion (with optional
/// note).
///
/// The screen drives entirely off [sessionControllerProvider]; the exercise is
/// loaded by the controller (after the first frame) so the routed widget's
/// element tree stays stable during the push transition.
class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key, required this.exerciseId});

  final int exerciseId;

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  late final SessionController _controller;
  bool _muted = false;
  bool _notFound = false;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(sessionControllerProvider.notifier);
    // Load AFTER the first frame: mutating the watched provider during the push
    // transition is what churned the element tree and tripped the framework's
    // `_dependents.isEmpty` assertion.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final found = await _controller.loadById(widget.exerciseId);
      // Don't spin forever if the exercise can't be loaded.
      if (mounted && !found) setState(() => _notFound = true);
    });
  }

  @override
  void dispose() {
    // Cancel the ticker on exit (the global provider's ref.onDispose won't fire
    // on a screen pop).
    _controller.disposeTimer();
    super.dispose();
  }

  Future<void> _confirmExit(AppLocalizations l10n) async {
    final ok = await showConfirmDialog(
      context,
      title: l10n.sessionExitTitle,
      message: l10n.sessionExitMessage,
      cancelLabel: l10n.commonCancel,
      confirmLabel: l10n.sessionExitConfirm,
    );
    if (ok && mounted) {
      _controller.abort();
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider);
    final exercise = session.exercise;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _confirmExit(l10n);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        color: _phaseColor(context, session.phase),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            title: Text(exercise?.name ?? ''),
            actions: [
              IconButton(
                tooltip: _muted ? l10n.sessionUnmute : l10n.sessionMute,
                icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
                onPressed: () {
                  setState(() => _muted = !_muted);
                  _controller.setMuted(_muted);
                },
              ),
            ],
          ),
          body: SafeArea(
            child: exercise == null
                ? (_notFound
                    ? _NotFoundView(onBack: () => context.pop())
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ))
                : session.isFinished
                    ? _CompletionView(controller: _controller, l10n: l10n)
                    : _RunningView(
                        session: session,
                        controller: _controller,
                        l10n: l10n,
                        onExit: () => _confirmExit(l10n),
                      ),
          ),
        ),
      ),
    );
  }

  Color _phaseColor(BuildContext context, TimerPhase phase) {
    final p = AppPalette.of(context);
    return switch (phase) {
      TimerPhase.squeeze => p.squeeze,
      TimerPhase.hold => p.hold,
      TimerPhase.release => p.release,
      TimerPhase.rest => p.rest,
      _ => Colors.blueGrey,
    };
  }
}

/// Shown when the exercise can't be loaded (so the screen never spins forever).
class _NotFoundView extends StatelessWidget {
  const _NotFoundView({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 56),
            const SizedBox(height: 16),
            const Text(
              'Egzersiz bulunamadı.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 24),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
              ),
              onPressed: onBack,
              child: const Text('Geri Dön'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RunningView extends StatelessWidget {
  const _RunningView({
    required this.session,
    required this.controller,
    required this.l10n,
    required this.onExit,
  });

  final SessionState session;
  final SessionController controller;
  final AppLocalizations l10n;
  final VoidCallback onExit;

  String _phaseLabel() => switch (session.phase) {
        TimerPhase.squeeze => l10n.sessionPhaseSqueeze,
        TimerPhase.hold => l10n.sessionPhaseHold,
        TimerPhase.release => l10n.sessionPhaseRelease,
        TimerPhase.rest => l10n.sessionPhaseRest,
        _ => '',
      };

  /// Total seconds of the current phase, read from the exercise config.
  int _phaseTotalSeconds() {
    final e = session.exercise;
    if (e == null) return 0;
    return switch (session.phase) {
      TimerPhase.squeeze => e.squeezeSeconds,
      TimerPhase.hold => e.holdSeconds,
      TimerPhase.release => e.releaseSeconds,
      TimerPhase.rest => e.restSeconds,
      _ => 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    const white = TextStyle(color: Colors.white);
    final total = _phaseTotalSeconds();
    final remainingFraction =
        total > 0 ? (session.secondsLeftInPhase / total).clamp(0.0, 1.0) : 0.0;

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          l10n.sessionSetProgress(session.currentSet, session.totalSets),
          textAlign: TextAlign.center,
          style: white.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.sessionRepProgress(session.currentRep, session.totalReps),
          textAlign: TextAlign.center,
          style: white.copyWith(fontSize: 16, color: Colors.white70),
        ),
        // The ring owns the middle region and centers within it. AspectRatio(1)
        // inside a 280px cap keeps it a bounded square — it can never fill the
        // screen and never overflows on small or large displays.
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280, maxHeight: 280),
              child: AspectRatio(
                aspectRatio: 1,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 950),
                  curve: Curves.linear,
                  tween:
                      Tween(begin: remainingFraction, end: remainingFraction),
                  builder: (context, value, _) => CustomPaint(
                    painter: _PhaseRingPainter(progress: value),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${session.secondsLeftInPhase}',
                            style: white.copyWith(
                                fontSize: 88, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _phaseLabel(),
                            style: white.copyWith(
                                fontSize: 26, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Controls: a full-width primary Pause/Resume, then İptal + Atla as two
        // equal halves. Laid out as a primary button + a Row of Expanded
        // buttons so it can NEVER overflow horizontally (the previous single
        // Row of three icon-buttons overflowed because the themed FilledButton
        // demands full width — that RenderFlex overflow is what corrupted the
        // whole screen).
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                ),
                icon: Icon(session.isRunning ? Icons.pause : Icons.play_arrow),
                label: Text(
                    session.isRunning ? l10n.sessionPause : l10n.sessionResume),
                onPressed: () => session.isRunning
                    ? controller.pause()
                    : (session.phase == TimerPhase.idle
                        ? controller.start()
                        : controller.resume()),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white70),
                        minimumSize: const Size.fromHeight(48),
                      ),
                      icon: const Icon(Icons.close),
                      label: Text(l10n.sessionAbort),
                      onPressed: onExit,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white70),
                        minimumSize: const Size.fromHeight(48),
                      ),
                      icon: const Icon(Icons.skip_next),
                      label: Text(l10n.sessionSkip),
                      onPressed: controller.skip,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Draws the countdown ring: a faint full track with a white arc showing the
/// fraction of the current phase still remaining.
class _PhaseRingPainter extends CustomPainter {
  _PhaseRingPainter({required this.progress});

  final double progress; // 0..1 remaining

  static const _stroke = 14.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - _stroke) / 2;

    final track = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = _stroke;
    final arc = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = _stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, track);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress.clamp(0.0, 1.0),
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(_PhaseRingPainter old) => old.progress != progress;
}

class _CompletionView extends StatefulWidget {
  const _CompletionView({required this.controller, required this.l10n});

  final SessionController controller;
  final AppLocalizations l10n;

  @override
  State<_CompletionView> createState() => _CompletionViewState();
}

class _CompletionViewState extends State<_CompletionView> {
  final _noteController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);
    final unlocked = await widget.controller.saveCompletion(
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
    );
    if (!mounted) return;
    if (unlocked.isNotEmpty) {
      await showBadgeUnlockSheet(context, unlocked);
      messenger.showSnackBar(
        SnackBar(
          content: Text(widget.l10n.badgeUnlockedSnack(unlocked.first.title)),
        ),
      );
    }
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            tween: Tween(begin: 0, end: 1),
            builder: (context, value, child) => Opacity(
              opacity: value.clamp(0.0, 1.0),
              child: Transform.scale(scale: value, child: child),
            ),
            child:
                const Icon(Icons.check_circle, color: Colors.white, size: 96),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.sessionCompleted,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _noteController,
            style: const TextStyle(color: Colors.white),
            maxLines: 3,
            decoration: InputDecoration(
              hintText: l10n.sessionNoteHint,
              hintStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white24,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87),
            onPressed: _saving ? null : _save,
            child: Text(l10n.sessionFinish),
          ),
        ],
      ),
    );
  }
}
