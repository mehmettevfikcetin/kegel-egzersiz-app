import 'package:drift/drift.dart';

import '../../core/database/app_database.dart';
import '../../core/database/daos/program_dao.dart';

/// CRUD surface for [Programs], wrapping the existing [ProgramDao].
///
/// The built-in (seeded) program is protected: [delete] won't remove it, and
/// callers should treat `program.isBuiltIn == true` as non-editable metadata.
class ProgramRepository {
  ProgramRepository(this._db);

  final AppDatabase _db;
  ProgramDao get _dao => _db.programDao;

  /// All programs (built-in + user-created), reactive.
  Stream<List<Program>> watchAll() => _dao.watchPrograms();

  /// The single active program, or null if none is active yet.
  Future<Program?> active() => _dao.activeProgram();

  /// Atomically make [programId] the only active program.
  Future<void> setActive(int programId) => _dao.setActiveProgram(programId);

  Future<Program?> byId(int id) =>
      (_db.select(_db.programs)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  /// Create a user program. Returns the new row id.
  Future<int> create({
    required String name,
    String? description,
    bool isActive = false,
  }) =>
      _db.into(_db.programs).insert(ProgramsCompanion.insert(
            name: name,
            description: Value(description),
            isActive: Value(isActive),
          ));

  /// Replace an entire program row.
  Future<bool> update(Program program) =>
      _db.update(_db.programs).replace(program);

  /// Delete a user program (no-op on the built-in one). Returns rows removed.
  Future<int> delete(int id) => _dao.deleteProgram(id);
}
