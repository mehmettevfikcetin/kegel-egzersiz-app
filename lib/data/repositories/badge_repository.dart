import '../../core/database/app_database.dart';
import '../../core/database/daos/badge_dao.dart';

/// CRUD surface for [Badges], wrapping the existing [BadgeDao].
class BadgeRepository {
  BadgeRepository(this._db);

  final AppDatabase _db;
  BadgeDao get _dao => _db.badgeDao;

  /// All badges (locked + unlocked), reactive.
  Stream<List<Badge>> watchAll() => _dao.watchBadges();

  /// Only the unlocked badges, reactive.
  Stream<List<Badge>> watchUnlocked() =>
      (_db.select(_db.badges)..where((t) => t.isUnlocked.equals(true))).watch();

  Future<Badge?> byCode(String code) =>
      (_db.select(_db.badges)..where((t) => t.code.equals(code)))
          .getSingleOrNull();

  /// Mark the badge with [code] unlocked (idempotent — only flips locked ones).
  Future<void> unlock(String code) => _dao.unlock(code);
}
