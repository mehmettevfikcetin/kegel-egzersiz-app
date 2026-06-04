import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_palette.dart';
import '../application/onboarding_providers.dart';

/// First-launch onboarding: what the program is, how it works, and a chance to
/// enable reminders. Gated by the router via [onboardingCompletedProvider];
/// finishing persists the reminder times into [AppSettings] (the same path the
/// Settings screen uses) and flips the completed flag.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  TimeOfDay _morning = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _evening = const TimeOfDay(hour: 20, minute: 0);
  bool _finishing = false;

  static const _pageCount = 3;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < _pageCount - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    if (_finishing) return;
    setState(() => _finishing = true);
    final l10n = AppLocalizations.of(context);
    final db = ref.read(databaseProvider);
    final notif = ref.read(notificationServiceProvider);

    await notif.requestPermissions();
    await db.updateSettings(AppSettingsCompanion(
      morningReminderTime: Value(_format(_morning)),
      eveningReminderTime: Value(_format(_evening)),
      remindersEnabled: const Value(true),
    ));
    await notif.scheduleDailyReminders(
      [_morning, _evening],
      title: l10n.remindersDailyTitle,
      body: l10n.remindersDailyBody,
    );

    await ref.read(onboardingCompletedProvider.notifier).complete();
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isLast = _page == _pageCount - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _finishing ? null : _finish,
                child: Text(l10n.onboardingSkip),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  _IntroPage(
                    icon: Icons.self_improvement,
                    title: l10n.onboardingTitle1,
                    body: l10n.onboardingBody1,
                  ),
                  _HowItWorksPage(l10n: l10n),
                  _RemindersPage(
                    l10n: l10n,
                    morning: _morning,
                    evening: _evening,
                    onPickMorning: (t) => setState(() => _morning = t),
                    onPickEvening: (t) => setState(() => _evening = t),
                  ),
                ],
              ),
            ),
            _Dots(count: _pageCount, active: _page),
            Padding(
              padding: const EdgeInsets.all(24),
              child: FilledButton(
                onPressed: _finishing ? null : _next,
                child: Text(isLast ? l10n.onboardingFinish : l10n.onboardingNext),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _format(TimeOfDay t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

class _IntroPage extends StatelessWidget {
  const _IntroPage({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 96, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 32),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _HowItWorksPage extends StatelessWidget {
  const _HowItWorksPage({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.onboardingTitle2,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 32),
          _Step(
            index: 1,
            color: palette.phase1,
            icon: Icons.fitness_center,
            text: l10n.onboardingStep1,
          ),
          const SizedBox(height: 20),
          _Step(
            index: 2,
            color: palette.phase2,
            icon: Icons.timer_outlined,
            text: l10n.onboardingStep2,
          ),
          const SizedBox(height: 20),
          _Step(
            index: 3,
            color: palette.phase3,
            icon: Icons.emoji_events_outlined,
            text: l10n.onboardingStep3,
          ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.index,
    required this.color,
    required this.icon,
    required this.text,
  });

  final int index;
  final Color color;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}

class _RemindersPage extends StatelessWidget {
  const _RemindersPage({
    required this.l10n,
    required this.morning,
    required this.evening,
    required this.onPickMorning,
    required this.onPickEvening,
  });

  final AppLocalizations l10n;
  final TimeOfDay morning;
  final TimeOfDay evening;
  final ValueChanged<TimeOfDay> onPickMorning;
  final ValueChanged<TimeOfDay> onPickEvening;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_active_outlined,
              size: 72, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 24),
          Text(
            l10n.onboardingTitle3,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.onboardingBody3,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _TimeRow(
            label: l10n.onboardingMorning,
            time: morning,
            onPick: onPickMorning,
          ),
          const SizedBox(height: 12),
          _TimeRow(
            label: l10n.onboardingEvening,
            time: evening,
            onPick: onPickEvening,
          ),
        ],
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({
    required this.label,
    required this.time,
    required this.onPick,
  });

  final String label;
  final TimeOfDay time;
  final ValueChanged<TimeOfDay> onPick;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.schedule),
        title: Text(label),
        trailing: Text(
          time.format(context),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: () async {
          final picked =
              await showTimePicker(context: context, initialTime: time);
          if (picked != null) onPick(picked);
        },
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.active});

  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: i == active ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == active ? scheme.primary : scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}
