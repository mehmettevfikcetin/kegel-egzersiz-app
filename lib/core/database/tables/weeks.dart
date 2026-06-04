import 'package:drift/drift.dart';

import 'programs.dart';

/// A week within a program. `phase` groups weeks (4 phases × 2 weeks = 8).
/// `isUnlocked` drives the level system (week 1 unlocked, rest gated at 70%).
class Weeks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get programId =>
      integer().references(Programs, #id, onDelete: KeyAction.cascade)();
  IntColumn get weekIndex => integer()(); // 1..8
  IntColumn get phase => integer()(); // 1..4
  TextColumn get title => text().nullable()();

  /// Human-readable phase label (e.g. "Temel", "Gelişim") for the UI.
  TextColumn get phaseName => text().nullable()();

  BoolColumn get isUnlocked => boolean().withDefault(const Constant(false))();

  /// Completion ratio (0..1) of the *previous* week required to unlock this one.
  RealColumn get unlockThreshold =>
      real().withDefault(const Constant(0.70))();
}
