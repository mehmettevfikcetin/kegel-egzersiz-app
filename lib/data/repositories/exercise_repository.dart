import '../../core/database/app_database.dart';
import '../../core/database/daos/program_dao.dart';

/// CRUD surface for [Exercises], wrapping the existing [ProgramDao].
class ExerciseRepository {
  ExerciseRepository(this._db);

  final AppDatabase _db;
  ProgramDao get _dao => _db.programDao;

  /// Exercises of a week, ordered by orderIndex, reactive.
  Stream<List<Exercise>> watchForWeek(int weekId) => _dao.watchExercises(weekId);

  Future<Exercise?> byId(int id) => _dao.exerciseById(id);

  /// Insert an exercise. Returns the new row id.
  Future<int> insert(ExercisesCompanion entry) => _dao.insertExercise(entry);

  /// Replace an entire exercise row.
  Future<bool> update(Exercise exercise) => _dao.updateExercise(exercise);

  Future<int> delete(int id) => _dao.deleteExercise(id);
}
