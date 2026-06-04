import 'package:drift/drift.dart';

/// A training program — either the built-in 8-week default or a user-created one.
class Programs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();

  /// True for the seeded default program; protects it from seed re-runs
  /// overwriting user data and lets the UI mark it as non-deletable.
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(false))();

  /// Exactly one program should be active at a time (the one being tracked).
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
