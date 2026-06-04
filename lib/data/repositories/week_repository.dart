import 'package:drift/drift.dart';

import '../../core/database/app_database.dart';
import '../../core/database/daos/program_dao.dart';

/// CRUD surface for [Weeks]. There is no dedicated DAO for weeks, so unlock
/// reads/writes reuse [ProgramDao] and the remaining CRUD goes straight to the
/// table via the database.
class WeekRepository {
  WeekRepository(this._db);

  final AppDatabase _db;
  ProgramDao get _dao => _db.programDao;

  /// Weeks of a program, ordered by weekIndex, reactive.
  Stream<List<Week>> watchForProgram(int programId) =>
      _dao.watchWeeks(programId);

  Future<Week?> byId(int id) =>
      (_db.select(_db.weeks)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insert(WeeksCompanion entry) => _db.into(_db.weeks).insert(entry);

  Future<bool> update(Week week) => _db.update(_db.weeks).replace(week);

  Future<int> delete(int id) =>
      (_db.delete(_db.weeks)..where((t) => t.id.equals(id))).go();

  Future<void> setUnlocked(int weekId, bool unlocked) =>
      _dao.setWeekUnlocked(weekId, unlocked);

  Future<void> setUnlockThreshold(int weekId, double threshold) =>
      (_db.update(_db.weeks)..where((t) => t.id.equals(weekId)))
          .write(WeeksCompanion(unlockThreshold: Value(threshold)));
}
