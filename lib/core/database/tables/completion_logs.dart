import 'package:drift/drift.dart';

import 'exercises.dart';
import 'weeks.dart';

/// Which daily set a completion belongs to. Stored as text (`.name`), so adding
/// `midday` is backward-compatible with rows written before it existed.
enum SessionType { morning, evening, midday }

/// One logged exercise completion. `weekId` is denormalized so completion
/// stats survive even if the source exercise is later deleted/edited.
class CompletionLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseId => integer()
      .nullable()
      .references(Exercises, #id, onDelete: KeyAction.setNull)();
  IntColumn get weekId =>
      integer().references(Weeks, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get completedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get session => textEnum<SessionType>()();
  IntColumn get holdSecondsAchieved => integer().nullable()();
  IntColumn get durationSeconds => integer().nullable()();
  TextColumn get note => text().nullable()();
}
