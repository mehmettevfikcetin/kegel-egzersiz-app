import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/exercises.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/utils/streak_calculator.dart';
import '../../../core/widgets/animated_counter.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_retry.dart';
import '../../../core/widgets/skeleton.dart';

/// Today's training plan resolved from the active program + current week, plus
/// which of today's exercises already have a completion log.
class _TodayPlan {
  const _TodayPlan({
    this.week,
    this.exercises = const [],
    this.completedToday = const {},
    this.weekLogCount = 0,
  });

  final Week? week;
  final List<Exercise> exercises;
  final Set<int> completedToday;

  /// Completion logs recorded in the current Mon–Sun calendar week.
  final int weekLogCount;

  bool get hasProgram => week != null;

  List<Exercise> byDayPart(DayPart part) =>
      exercises.where((e) => e.dayPart == part).toList();
}

final _todayPlanProvider =
    StreamProvider.autoDispose<_TodayPlan>((ref) async* {
  final db = ref.watch(databaseProvider);
  final program = await db.programDao.activeProgram();
  if (program == null) {
    yield const _TodayPlan();
    return;
  }

  final weeks = await db.programDao.watchWeeks(program.id).first;
  if (weeks.isEmpty) {
    yield const _TodayPlan();
    return;
  }

  final settings = await db.getSettings();
  final week = weeks.firstWhere(
    (w) => w.id == settings.currentWeekId,
    orElse: () => weeks.first,
  );

  final exercises = await db.programDao.watchExercises(week.id).first;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(const Duration(days: 1));
  // This calendar week's window (Mon..next Mon); today falls inside it, so
  // today's completions are derived from the same stream.
  final monday = today.subtract(Duration(days: now.weekday - 1));
  final nextMonday = monday.add(const Duration(days: 7));

  // Watch the week's logs so the plan + progress bar refresh the moment a
  // session is saved — no restart needed.
  yield* db.completionDao.watchLogsBetween(monday, nextMonday).map((weekLogs) {
    final completedToday = weekLogs
        .where((l) =>
            !l.completedAt.isBefore(today) && l.completedAt.isBefore(tomorrow))
        .map((l) => l.exerciseId)
        .whereType<int>()
        .toSet();
    return _TodayPlan(
      week: week,
      exercises: exercises,
      completedToday: completedToday,
      weekLogCount: weekLogs.length,
    );
  });
});

/// Dashboard: streak, today's morning/evening sets, and weekly progress.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ConfettiController _confetti =
      ConfettiController(duration: const Duration(seconds: 2));
  bool _celebrated = false;

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  /// Fire the confetti once when the whole day's set is complete; re-arm when
  /// it isn't (e.g. a new day, or before the last exercise is done).
  void _maybeCelebrate(bool dayComplete) {
    if (dayComplete && !_celebrated) {
      _celebrated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _confetti.play());
    } else if (!dayComplete && _celebrated) {
      _celebrated = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final planAsync = ref.watch(_todayPlanProvider);
    final daysAsync = ref.watch(completedDaysProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events_outlined),
            onPressed: () => context.push('/achievements'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Stack(
        children: [
          planAsync.when(
            loading: () => const SkeletonList(itemCount: 5),
            error: (e, _) => ErrorRetry(
              onRetry: () => ref.invalidate(_todayPlanProvider),
            ),
            data: (plan) {
              final completedDays = daysAsync.maybeWhen(
                  data: (d) => d, orElse: () => const <DateTime>[]);
              final morning = plan.byDayPart(DayPart.morning);
              final midday = plan.byDayPart(DayPart.midday);
              final evening = plan.byDayPart(DayPart.evening);
              final morningDone = morning.isNotEmpty &&
                  morning.every((e) => plan.completedToday.contains(e.id));
              final dayComplete = plan.exercises.isNotEmpty &&
                  plan.exercises
                      .every((e) => plan.completedToday.contains(e.id));
              _maybeCelebrate(dayComplete);

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _StreakCard(days: completedDays),
                  const SizedBox(height: 16),
                  if (!plan.hasProgram)
                    EmptyState(
                      icon: Icons.fitness_center,
                      title: l10n.homeNoProgram,
                    )
                  else ...[
                    _DateAndPhase(week: plan.week!),
                    const SizedBox(height: 16),
                    if (dayComplete)
                      _Banner(
                        text: l10n.homeDayComplete,
                        color: AppColors.rest,
                      )
                    else if (morningDone)
                      _Banner(
                        text: l10n.homeMorningDone,
                        color: AppColors.hold,
                      ),
                    if (morningDone || dayComplete) const SizedBox(height: 16),
                    if (plan.exercises.isEmpty)
                      EmptyState(
                        icon: Icons.event_available_outlined,
                        title: l10n.homeNoExercises,
                      )
                    else ...[
                      _DayPartSection(
                        title: l10n.homeMorningSet,
                        icon: Icons.wb_sunny_outlined,
                        exercises: morning,
                        completed: plan.completedToday,
                      ),
                      _DayPartSection(
                        title: l10n.homeMiddaySet,
                        icon: Icons.wb_twilight_outlined,
                        exercises: midday,
                        completed: plan.completedToday,
                      ),
                      _DayPartSection(
                        title: l10n.homeEveningSet,
                        icon: Icons.nightlight_outlined,
                        exercises: evening,
                        completed: plan.completedToday,
                      ),
                    ],
                    const SizedBox(height: 24),
                    _WeekStrip(
                      completedDays: completedDays,
                      done: plan.weekLogCount,
                      total: plan.exercises.length * 7,
                    ),
                  ],
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.25,
              colors: const [
                AppColors.rest,
                AppColors.hold,
                AppColors.release,
                AppColors.squeeze,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.days});

  final List<DateTime> days;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = StreakCalculator.currentStreak(days);
    final longest = StreakCalculator.longestStreak(days);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.local_fire_department,
                size: 40, color: AppColors.hold),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedCounter(
                  value: current,
                  style: Theme.of(context).textTheme.titleLarge,
                  builder: (c) => l10n.homeStreak(c),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.homeLongestStreak(longest),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DateAndPhase extends StatelessWidget {
  const _DateAndPhase({required this.week});

  final Week week;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dateLabel = DateFormat.yMMMMEEEEd('tr_TR').format(DateTime.now());
    final phaseColor = AppPalette.of(context).phaseColor(week.phase);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dateLabel, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 2),
              Text(
                l10n.programWeek(week.weekIndex),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        if (week.phaseName != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: phaseColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              week.phaseName!,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: phaseColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
      ],
    );
  }
}

class _DayPartSection extends StatelessWidget {
  const _DayPartSection({
    required this.title,
    required this.icon,
    required this.exercises,
    required this.completed,
  });

  final String title;
  final IconData icon;
  final List<Exercise> exercises;
  final Set<int> completed;

  @override
  Widget build(BuildContext context) {
    if (exercises.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: 8),
        for (final exercise in exercises)
          _ExerciseCard(
            exercise: exercise,
            done: completed.contains(exercise.id),
          ),
      ],
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.exercise, required this.done});

  final Exercise exercise;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: ListTile(
        leading: Text(
          _typeEmoji(exercise.type),
          style: const TextStyle(fontSize: 28),
        ),
        title: Text(exercise.name),
        subtitle: Text(
          '${l10n.homeExerciseSummary(exercise.sets, exercise.reps)} · '
          '${l10n.homeHoldSeconds(exercise.holdSeconds)}',
        ),
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) =>
              ScaleTransition(scale: anim, child: child),
          child: Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            key: ValueKey(done),
            color: done ? AppColors.rest : scheme.outline,
          ),
        ),
        onTap: () => context.push('/session/${exercise.id}'),
      ),
    );
  }

  static String _typeEmoji(ExerciseType type) => switch (type) {
        ExerciseType.kegel => '💪',
        ExerciseType.breath => '🌬️',
        ExerciseType.mind => '🧠',
        ExerciseType.combo => '🔄',
      };
}

class _Banner extends StatelessWidget {
  const _Banner({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _WeekStrip extends StatelessWidget {
  const _WeekStrip({
    required this.completedDays,
    required this.done,
    required this.total,
  });

  final List<DateTime> completedDays;
  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final monday = today.subtract(Duration(days: now.weekday - 1));
    final activeDays = completedDays
        .map((d) => DateTime(d.year, d.month, d.day))
        .toSet();
    final progress = total == 0 ? 0.0 : (done / total).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var i = 0; i < 7; i++)
              _DayDot(
                date: monday.add(Duration(days: i)),
                today: today,
                active: activeDays.contains(monday.add(Duration(days: i))),
              ),
          ],
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: scheme.surfaceContainerHighest,
            valueColor: const AlwaysStoppedAnimation(AppColors.rest),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.homeWeekProgress(done, total),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({
    required this.date,
    required this.today,
    required this.active,
  });

  final DateTime date;
  final DateTime today;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isToday = date == today;
    final label = DateFormat.E('tr_TR').format(date);
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
        ),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.rest : scheme.surfaceContainerHighest,
            border: isToday
                ? Border.all(color: scheme.primary, width: 2)
                : null,
          ),
          child: active
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : null,
        ),
      ],
    );
  }
}

