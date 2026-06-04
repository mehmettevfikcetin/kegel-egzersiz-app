import '../../core/database/app_database.dart';
import '../../core/database/daos/completion_dao.dart';

/// CRUD + stats surface for [CompletionLogs], wrapping the existing
/// [CompletionDao].
class CompletionLogRepository {
  CompletionLogRepository(this._db);

  final AppDatabase _db;
  CompletionDao get _dao => _db.completionDao;

  /// Record a completed exercise. Returns the new log id.
  Future<int> log(CompletionLogsCompanion entry) => _dao.logCompletion(entry);

  Future<void> updateNote(int logId, String? note) =>
      _dao.updateNote(logId, note);

  Stream<List<CompletionLog>> watchForDay(DateTime day) =>
      _dao.watchLogsForDay(day);

  Stream<List<CompletionLog>> watchBetween(DateTime start, DateTime end) =>
      _dao.watchLogsBetween(start, end);

  /// Fraction (0..1) of a week's exercises with at least one log — drives the
  /// level-unlock rule.
  Future<double> weekCompletionRatio(int weekId) =>
      _dao.weekCompletionRatio(weekId);

  Future<int> totalSessions() => _dao.totalSessions();

  /// Distinct calendar days with at least one completion, ascending.
  Future<List<DateTime>> completedDays() => _dao.completedDays();
}
