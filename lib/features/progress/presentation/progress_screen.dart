import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart' show compute;
// Hide Material's Badge widget — we use the Drift `Badge` data class here.
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/completion_logs.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/streak_calculator.dart';
import '../../../core/widgets/error_retry.dart';

/// All-time completed sessions.
final _totalCompletedProvider = StreamProvider.autoDispose<int>(
  (ref) => ref.watch(databaseProvider).completionDao.watchTotalSessions(),
);

/// Longest-ever streak, computed off the UI isolate via [compute] since it
/// sorts and scans the full completion history (a pure, isolate-safe reduction).
final _longestStreakProvider = FutureProvider.autoDispose<int>((ref) async {
  final days = await ref.watch(completedDaysProvider.future);
  return compute(_longestStreakOf, days);
});

int _longestStreakOf(List<DateTime> days) =>
    StreakCalculator.longestStreak(days);

/// Fraction (0..1) of the active program completed, weighting each week by its
/// exercise count: Σ(ratio·count) / Σ(count). Re-emits on every completion-log
/// change (driven off the completed-days watch) so the gauge updates live.
final _programCompletionProvider =
    StreamProvider.autoDispose<double>((ref) {
  final db = ref.watch(databaseProvider);
  // Recompute the weighted ratio on every completion-log change.
  return db.completionDao.watchCompletedDays().asyncMap((_) async {
    final program = await db.programDao.activeProgram();
    if (program == null) return 0.0;
    final weeks = await db.programDao.watchWeeks(program.id).first;

    var weightedSum = 0.0;
    var totalExercises = 0;
    for (final week in weeks) {
      final count = (await db.programDao.watchExercises(week.id).first).length;
      if (count == 0) continue;
      final ratio = await db.completionDao.weekCompletionRatio(week.id);
      weightedSum += ratio * count;
      totalExercises += count;
    }
    return totalExercises == 0 ? 0.0 : weightedSum / totalExercises;
  });
});

/// Completion logs over the last ~14 weeks — feeds both the weekly bar chart
/// (last 8 weeks) and the activity calendar (last ~3 months).
final _recentLogsProvider =
    StreamProvider.autoDispose<List<CompletionLog>>((ref) {
  final db = ref.watch(databaseProvider);
  final now = DateTime.now();
  final start =
      DateTime(now.year, now.month, now.day).subtract(const Duration(days: 97));
  return db.completionDao
      .watchLogsBetween(start, now.add(const Duration(days: 1)));
});

final _badgesProvider = StreamProvider.autoDispose<List<Badge>>(
  (ref) => ref.watch(databaseProvider).badgeDao.watchBadges(),
);

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProgress)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SummaryCards(),
          SizedBox(height: 24),
          _WeeklyChartSection(),
          SizedBox(height: 24),
          _ActivitySection(),
          SizedBox(height: 24),
          _BadgeStrip(),
        ],
      ),
    );
  }
}

class _SummaryCards extends ConsumerWidget {
  const _SummaryCards();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final total = ref.watch(_totalCompletedProvider).asData?.value ?? 0;
    final days = ref.watch(completedDaysProvider).asData?.value ?? const [];
    final completion = ref.watch(_programCompletionProvider).asData?.value ?? 0;
    final current = StreakCalculator.currentStreak(days);
    final longest = ref.watch(_longestStreakProvider).asData?.value ?? 0;

    // IntrinsicHeight bounds the Row's height to the tallest card so
    // CrossAxisAlignment.stretch is valid — inside the vertically-unbounded
    // ListView, stretch alone forces an infinite-height constraint, which
    // silently fails layout and blanks the whole Progress body.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _SummaryCard(
              icon: Icons.fitness_center,
              value: '$total',
              label: l10n.progressTotalCompleted,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _SummaryCard(
              icon: Icons.local_fire_department,
              value: '$current',
              label: '${l10n.progressCurrentStreak}\n'
                  '${l10n.progressLongestStreak}: $longest',
              color: AppColors.hold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _SummaryCard(
              icon: Icons.flag,
              value: '${(completion * 100).round()}%',
              label: l10n.progressCompletion,
              color: AppColors.rest,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.value,
    required this.label,
    this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? Theme.of(context).colorScheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Icon(icon, color: tint, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklyChartSection extends ConsumerWidget {
  const _WeeklyChartSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final logsAsync = ref.watch(_recentLogsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.progressWeeklyTitle,
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: logsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => ErrorRetry(
              onRetry: () => ref.invalidate(_recentLogsProvider),
            ),
            data: (logs) {
              if (logs.isEmpty) {
                return Center(
                  child: Text(
                    'Henüz veri yok',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                  ),
                );
              }
              final now = DateTime.now();
              final thisMonday = DateTime(now.year, now.month, now.day)
                  .subtract(Duration(days: now.weekday - 1));
              final pct = _weeklyCompletionPct(logs, now);
              final dayMonth = DateFormat('d MMM', 'tr_TR');
              return BarChart(
                BarChartData(
                  maxY: 100,
                  alignment: BarChartAlignment.spaceAround,
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 25,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: scheme.outlineVariant.withValues(alpha: 0.3),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 25,
                        reservedSize: 34,
                        getTitlesWidget: (value, meta) => Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            '%${value.toInt()}',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          // 0..7, where 7 is the current Mon–Sun week.
                          final monday =
                              thisMonday.subtract(Duration(days: 7 * (7 - i)));
                          final label =
                              i == 7 ? 'Bu hafta' : dayMonth.format(monday);
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(label,
                                style: Theme.of(context).textTheme.labelSmall),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    for (var i = 0; i < pct.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: pct[i],
                            color: i == pct.length - 1
                                ? scheme.primary
                                : scheme.primaryContainer,
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Per-week completion as active-days/7 (×100) for the last 8 weeks; the last
  /// entry is the current Mon–Sun week.
  static List<double> _weeklyCompletionPct(
      List<CompletionLog> logs, DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final thisMonday = today.subtract(Duration(days: now.weekday - 1));
    final result = <double>[];
    for (var w = 7; w >= 0; w--) {
      final weekStart = thisMonday.subtract(Duration(days: 7 * w));
      final weekEnd = weekStart.add(const Duration(days: 7));
      final activeDays = <DateTime>{};
      for (final log in logs) {
        final d = DateTime(log.completedAt.year, log.completedAt.month,
            log.completedAt.day);
        if (!d.isBefore(weekStart) && d.isBefore(weekEnd)) activeDays.add(d);
      }
      result.add(activeDays.length / 7 * 100);
    }
    return result;
  }
}

class _ActivitySection extends ConsumerWidget {
  const _ActivitySection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final logsAsync = ref.watch(_recentLogsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.progressActivityTitle,
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        logsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ErrorRetry(
            onRetry: () => ref.invalidate(_recentLogsProvider),
          ),
          data: (logs) => _ActivityGrid(levels: _activityLevels(logs)),
        ),
      ],
    );
  }

  /// Day → activity level: 2 (full) when both a morning AND evening log exist,
  /// 1 (partial) when at least one log exists, otherwise the day is absent.
  static Map<DateTime, int> _activityLevels(List<CompletionLog> logs) {
    final byDay = <DateTime, Set<SessionType>>{};
    for (final log in logs) {
      final d = DateTime(
          log.completedAt.year, log.completedAt.month, log.completedAt.day);
      (byDay[d] ??= <SessionType>{}).add(log.session);
    }
    return byDay.map((day, sessions) {
      final full = sessions.contains(SessionType.morning) &&
          sessions.contains(SessionType.evening);
      return MapEntry(day, full ? 2 : 1);
    });
  }
}

class _ActivityGrid extends StatelessWidget {
  const _ActivityGrid({required this.levels});

  final Map<DateTime, int> levels;

  static const int _columns = 13; // 13 × 7 = 91 days (~3 months)
  static const double _columnWidth = 20; // cell 16 + 2px margin each side

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thisMonday = today.subtract(Duration(days: now.weekday - 1));
    final startMonday =
        thisMonday.subtract(const Duration(days: 7 * (_columns - 1)));
    final columnMondays = [
      for (var w = 0; w < _columns; w++) startMonday.add(Duration(days: 7 * w)),
    ];
    final monthFmt = DateFormat('MMM', 'tr_TR');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Month labels — shown above the first column of each new month.
              Row(
                children: [
                  for (var w = 0; w < _columns; w++)
                    SizedBox(
                      width: _columnWidth,
                      height: 16,
                      child: (w == 0 ||
                              columnMondays[w].month !=
                                  columnMondays[w - 1].month)
                          ? OverflowBox(
                              alignment: Alignment.centerLeft,
                              minWidth: 0,
                              maxWidth: 60,
                              child: Text(
                                monthFmt.format(columnMondays[w]),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.visible,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: scheme.onSurfaceVariant),
                              ),
                            )
                          : null,
                    ),
                ],
              ),
              const SizedBox(height: 4),
              // Day cells — one Column per week, 7 days each.
              Row(
                children: [
                  for (var w = 0; w < _columns; w++)
                    Column(
                      children: [
                        for (var d = 0; d < 7; d++)
                          Builder(builder: (context) {
                            final date =
                                startMonday.add(Duration(days: 7 * w + d));
                            final level = date.isAfter(today)
                                ? -1
                                : (levels[date] ?? 0);
                            return _ActivityCell(level: level);
                          }),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            _LegendItem(
                color: scheme.surfaceContainerHighest, label: 'Yapılmadı'),
            _LegendItem(
                color: AppColors.rest.withValues(alpha: 0.4), label: 'Kısmi'),
            _LegendItem(color: AppColors.rest, label: 'Tamamlandı'),
          ],
        ),
      ],
    );
  }
}

/// One swatch + label in the activity grid legend (colours match the cells).
class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

class _ActivityCell extends StatelessWidget {
  const _ActivityCell({required this.level});

  /// -1 = future (blank), 0 = missed, 1 = partial, 2 = full.
  final int level;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (level) {
      2 => AppColors.rest,
      1 => AppColors.rest.withValues(alpha: 0.4),
      0 => scheme.surfaceContainerHighest,
      _ => Colors.transparent,
    };
    return Container(
      width: 16,
      height: 16,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class _BadgeStrip extends ConsumerWidget {
  const _BadgeStrip();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final badges = ref.watch(_badgesProvider).asData?.value ?? const [];
    final unlocked = badges.where((b) => b.isUnlocked).length;

    return Card(
      child: ListTile(
        leading: const Icon(Icons.emoji_events, color: AppColors.hold),
        title: Text(l10n.achievementsTitle),
        subtitle: Text(l10n.progressBadgesSummary(unlocked, badges.length)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/achievements'),
      ),
    );
  }
}
