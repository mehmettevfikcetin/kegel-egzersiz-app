import 'package:drift/drift.dart';

import '../converters.dart';
import 'weeks.dart';

/// Which part of the day an exercise belongs to. Stored as text (`.name`).
enum DayPart { morning, midday, evening }

/// The kind of exercise — drives UI grouping and which timer/guidance to show.
/// Stored as text (`.name`).
enum ExerciseType { kegel, breath, mind, combo }

/// A single exercise definition. The four phase durations (in seconds) plus
/// `reps`/`sets` fully describe one timer run. For `breath` exercises the same
/// fields map to a breathing cadence (squeeze = inhale, release = exhale).
class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get weekId =>
      integer().references(Weeks, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();

  /// When in the day this exercise is performed.
  TextColumn get dayPart =>
      textEnum<DayPart>().withDefault(Constant(DayPart.morning.name))();

  /// What kind of exercise this is (kegel / breath / mind / combo).
  TextColumn get type =>
      textEnum<ExerciseType>().withDefault(Constant(ExerciseType.kegel.name))();

  /// Free-text explanation shown above the timer.
  TextColumn get description => text().nullable()();

  /// Ordered step-by-step instructions, stored as a JSON list.
  TextColumn get steps =>
      text().map(const StringListConverter()).nullable()();

  IntColumn get squeezeSeconds => integer()();
  IntColumn get holdSeconds => integer()();
  IntColumn get releaseSeconds => integer()();
  IntColumn get restSeconds => integer()();
  IntColumn get reps => integer()();
  IntColumn get sets => integer().withDefault(const Constant(1))();
}
