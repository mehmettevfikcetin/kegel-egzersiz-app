import 'package:drift/drift.dart';

import '../app_database.dart';
import '../seed/default_program.dart';
import '../tables/exercises.dart';
import '../tables/programs.dart';
import '../tables/weeks.dart';

part 'program_dao.g.dart';

@DriftAccessor(tables: [Programs, Weeks, Exercises])
class ProgramDao extends DatabaseAccessor<AppDatabase> with _$ProgramDaoMixin {
  ProgramDao(super.db);

  Stream<List<Program>> watchPrograms() => select(programs).watch();

  Future<Program?> activeProgram() =>
      (select(programs)..where((t) => t.isActive.equals(true)))
          .getSingleOrNull();

  /// Atomically make [programId] the only active program.
  Future<void> setActiveProgram(int programId) => transaction(() async {
        await update(programs).write(const ProgramsCompanion(
          isActive: Value(false),
        ));
        await (update(programs)..where((t) => t.id.equals(programId)))
            .write(const ProgramsCompanion(isActive: Value(true)));
      });

  Stream<List<Week>> watchWeeks(int programId) => (select(weeks)
        ..where((t) => t.programId.equals(programId))
        ..orderBy([(t) => OrderingTerm(expression: t.weekIndex)]))
      .watch();

  Stream<List<Exercise>> watchExercises(int weekId) => (select(exercises)
        ..where((t) => t.weekId.equals(weekId))
        ..orderBy([(t) => OrderingTerm(expression: t.orderIndex)]))
      .watch();

  Future<Exercise?> exerciseById(int id) =>
      (select(exercises)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> setWeekUnlocked(int weekId, bool unlocked) =>
      (update(weeks)..where((t) => t.id.equals(weekId)))
          .write(WeeksCompanion(isUnlocked: Value(unlocked)));

  Future<int> insertExercise(ExercisesCompanion entry) =>
      into(exercises).insert(entry);

  Future<bool> updateExercise(Exercise entry) =>
      update(exercises).replace(entry);

  Future<int> deleteExercise(int id) =>
      (delete(exercises)..where((t) => t.id.equals(id))).go();

  Future<int> deleteProgram(int id) =>
      (delete(programs)..where((t) => t.id.equals(id) & t.isBuiltIn.equals(false)))
          .go();

  Future<int> insertProgram(ProgramsCompanion entry) =>
      into(programs).insert(entry);

  Future<int> insertWeek(WeeksCompanion entry) => into(weeks).insert(entry);

  /// Removes a week; its exercises cascade-delete via the FK.
  Future<int> deleteWeek(int id) =>
      (delete(weeks)..where((t) => t.id.equals(id))).go();

  Future<void> setWeekThreshold(int weekId, double threshold) =>
      (update(weeks)..where((t) => t.id.equals(weekId)))
          .write(WeeksCompanion(unlockThreshold: Value(threshold)));

  /// Persists a new exercise order by writing `orderIndex = position` for each
  /// id in [orderedIds]. Drives the ReorderableListView in the editor.
  Future<void> reorderExercises(int weekId, List<int> orderedIds) =>
      transaction(() async {
        for (var i = 0; i < orderedIds.length; i++) {
          await (update(exercises)..where((t) => t.id.equals(orderedIds[i])))
              .write(ExercisesCompanion(orderIndex: Value(i)));
        }
      });

  /// Creates a new, empty editable program named [name] with a single empty
  /// week (week 1, unlocked) and no exercises. The user fills in weeks and
  /// exercises manually. Returns the new program id.
  Future<int> createEmptyProgram(String name) => transaction(() async {
        final newProgramId =
            await into(programs).insert(ProgramsCompanion.insert(
          name: name,
          description: const Value(null),
          isBuiltIn: const Value(false),
          isActive: const Value(false),
        ));

        await into(weeks).insert(WeeksCompanion.insert(
          programId: newProgramId,
          weekIndex: 1,
          phase: 1,
          isUnlocked: const Value(true),
        ));

        return newProgramId;
      });

  /// Deep-copies the built-in program (its weeks + exercises) into a new
  /// editable, non-built-in program named [name]. Returns the new program id.
  Future<int> createProgramFromBuiltIn(String name) => transaction(() async {
        final builtIn = await (select(programs)
              ..where((t) => t.isBuiltIn.equals(true)))
            .getSingleOrNull();

        final newProgramId =
            await into(programs).insert(ProgramsCompanion.insert(
          name: name,
          description: Value(builtIn?.description),
          isBuiltIn: const Value(false),
          isActive: const Value(false),
        ));

        if (builtIn == null) return newProgramId;

        final srcWeeks = await (select(weeks)
              ..where((t) => t.programId.equals(builtIn.id))
              ..orderBy([(t) => OrderingTerm(expression: t.weekIndex)]))
            .get();

        for (final w in srcWeeks) {
          final newWeekId = await into(weeks).insert(WeeksCompanion.insert(
            programId: newProgramId,
            weekIndex: w.weekIndex,
            phase: w.phase,
            title: Value(w.title),
            phaseName: Value(w.phaseName),
            unlockThreshold: Value(w.unlockThreshold),
            isUnlocked: Value(w.weekIndex == 1),
          ));

          final srcExercises = await (select(exercises)
                ..where((t) => t.weekId.equals(w.id))
                ..orderBy([(t) => OrderingTerm(expression: t.orderIndex)]))
              .get();

          for (final e in srcExercises) {
            await into(exercises).insert(ExercisesCompanion.insert(
              weekId: newWeekId,
              name: e.name,
              orderIndex: Value(e.orderIndex),
              dayPart: Value(e.dayPart),
              type: Value(e.type),
              description: Value(e.description),
              steps: Value(e.steps),
              squeezeSeconds: e.squeezeSeconds,
              holdSeconds: e.holdSeconds,
              releaseSeconds: e.releaseSeconds,
              restSeconds: e.restSeconds,
              reps: e.reps,
              sets: Value(e.sets),
            ));
          }
        }
        return newProgramId;
      });

  /// Restores the built-in program to its shipped defaults: deletes the current
  /// built-in program (weeks/exercises cascade) and re-inserts from
  /// [defaultProgram]. User-created programs and logs are untouched.
  Future<void> resetDefaultProgram() => transaction(() async {
        final existing = await (select(programs)
              ..where((t) => t.isBuiltIn.equals(true)))
            .get();
        final wasActive = existing.any((p) => p.isActive);
        for (final p in existing) {
          await (delete(programs)..where((t) => t.id.equals(p.id))).go();
        }

        final programId = await into(programs).insert(ProgramsCompanion.insert(
          name: defaultProgram.name,
          description: Value(defaultProgram.description),
          isBuiltIn: const Value(true),
          isActive: Value(wasActive),
        ));

        for (final w in defaultProgram.weeks) {
          final weekId = await into(weeks).insert(WeeksCompanion.insert(
            programId: programId,
            weekIndex: w.weekIndex,
            phase: w.phase,
            title: Value(w.title),
            phaseName: Value(w.phaseName),
            unlockThreshold: Value(w.unlockThreshold),
            isUnlocked: Value(w.weekIndex == 1),
          ));

          var order = 0;
          for (final e in w.exercises) {
            await into(exercises).insert(ExercisesCompanion.insert(
              weekId: weekId,
              name: e.name,
              orderIndex: Value(order++),
              dayPart: Value(e.dayPart),
              type: Value(e.type),
              description: Value(e.description),
              steps: Value(e.steps),
              squeezeSeconds: e.squeeze,
              holdSeconds: e.hold,
              releaseSeconds: e.release,
              restSeconds: e.rest,
              reps: e.reps,
              sets: Value(e.sets),
            ));
          }
        }
      });
}
