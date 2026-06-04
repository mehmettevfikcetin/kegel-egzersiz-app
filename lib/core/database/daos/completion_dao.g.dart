// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_dao.dart';

// ignore_for_file: type=lint
mixin _$CompletionDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProgramsTable get programs => attachedDatabase.programs;
  $WeeksTable get weeks => attachedDatabase.weeks;
  $ExercisesTable get exercises => attachedDatabase.exercises;
  $CompletionLogsTable get completionLogs => attachedDatabase.completionLogs;
  CompletionDaoManager get managers => CompletionDaoManager(this);
}

class CompletionDaoManager {
  final _$CompletionDaoMixin _db;
  CompletionDaoManager(this._db);
  $$ProgramsTableTableManager get programs =>
      $$ProgramsTableTableManager(_db.attachedDatabase, _db.programs);
  $$WeeksTableTableManager get weeks =>
      $$WeeksTableTableManager(_db.attachedDatabase, _db.weeks);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db.attachedDatabase, _db.exercises);
  $$CompletionLogsTableTableManager get completionLogs =>
      $$CompletionLogsTableTableManager(
        _db.attachedDatabase,
        _db.completionLogs,
      );
}
