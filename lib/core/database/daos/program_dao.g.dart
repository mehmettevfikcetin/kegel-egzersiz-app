// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_dao.dart';

// ignore_for_file: type=lint
mixin _$ProgramDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProgramsTable get programs => attachedDatabase.programs;
  $WeeksTable get weeks => attachedDatabase.weeks;
  $ExercisesTable get exercises => attachedDatabase.exercises;
  ProgramDaoManager get managers => ProgramDaoManager(this);
}

class ProgramDaoManager {
  final _$ProgramDaoMixin _db;
  ProgramDaoManager(this._db);
  $$ProgramsTableTableManager get programs =>
      $$ProgramsTableTableManager(_db.attachedDatabase, _db.programs);
  $$WeeksTableTableManager get weeks =>
      $$WeeksTableTableManager(_db.attachedDatabase, _db.weeks);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db.attachedDatabase, _db.exercises);
}
