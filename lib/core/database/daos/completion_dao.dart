import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/completion_logs.dart';
import '../tables/exercises.dart';
import '../tables/weeks.dart';

part 'completion_dao.g.dart';

@DriftAccessor(tables: [CompletionLogs, Exercises, Weeks])
class CompletionDao extends DatabaseAccessor<AppDatabase>
    with _$CompletionDaoMixin {
  CompletionDao(super.db);

  Future<int> logCompletion(CompletionLogsCompanion log) =>
      into(completionLogs).insert(log);

  /// Deletes every completion log. Drives "İlerlemeyi Sıfırla" in settings.
  Future<int> clearAllLogs() => delete(completionLogs).go();

  Future<void> updateNote(int logId, String? note) =>
      (update(completionLogs)..where((t) => t.id.equals(logId)))
          .write(CompletionLogsCompanion(note: Value(note)));

  Stream<List<CompletionLog>> watchLogsForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return (select(completionLogs)
          ..where((t) => t.completedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm(expression: t.completedAt)]))
        .watch();
  }

  Stream<List<CompletionLog>> watchLogsBetween(DateTime start, DateTime end) =>
      (select(completionLogs)
            ..where((t) => t.completedAt.isBetweenValues(start, end)))
          .watch();

  /// Fraction (0..1) of a week's exercises with at least one completion log.
  /// Drives the 70% level-unlock rule.
  Future<double> weekCompletionRatio(int weekId) async {
    final totalExpr = exercises.id.count();
    final totalRow = await (selectOnly(exercises)
          ..addColumns([totalExpr])
          ..where(exercises.weekId.equals(weekId)))
        .getSingle();
    final total = totalRow.read(totalExpr) ?? 0;
    if (total == 0) return 0;

    final doneExpr = completionLogs.exerciseId.count(distinct: true);
    final doneRow = await (selectOnly(completionLogs)
          ..addColumns([doneExpr])
          ..where(completionLogs.weekId.equals(weekId)))
        .getSingle();
    final done = doneRow.read(doneExpr) ?? 0;
    return done / total;
  }

  Future<int> totalSessions() async {
    final countExpr = completionLogs.id.count();
    final row =
        await (selectOnly(completionLogs)..addColumns([countExpr])).getSingle();
    return row.read(countExpr) ?? 0;
  }

  /// Reactive twin of [totalSessions] — re-emits whenever logs change.
  Stream<int> watchTotalSessions() {
    final countExpr = completionLogs.id.count();
    return (selectOnly(completionLogs)..addColumns([countExpr]))
        .watchSingle()
        .map((row) => row.read(countExpr) ?? 0);
  }

  /// Distinct calendar days with at least one completion, ascending — used by
  /// the streak calculator and the history calendar markers.
  Future<List<DateTime>> completedDays() async {
    final rows = await select(completionLogs).get();
    final days = <DateTime>{};
    for (final r in rows) {
      days.add(DateTime(r.completedAt.year, r.completedAt.month, r.completedAt.day));
    }
    final sorted = days.toList()..sort();
    return sorted;
  }

  /// Reactive twin of [completedDays] — re-emits whenever logs change.
  Stream<List<DateTime>> watchCompletedDays() =>
      select(completionLogs).watch().map((rows) {
        final days = <DateTime>{};
        for (final r in rows) {
          days.add(DateTime(
              r.completedAt.year, r.completedAt.month, r.completedAt.day));
        }
        final sorted = days.toList()..sort();
        return sorted;
      });
}
