import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;

/// Single-row settings table (always id = 0). Reactive via `watchSingle()`.
/// Reminder times are stored as a `HH:mm` CSV (e.g. "08:00,20:00").
class AppSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();
  TextColumn get themeMode =>
      textEnum<ThemeMode>().withDefault(Constant(ThemeMode.system.name))();
  BoolColumn get forceUnlockAll => boolean().withDefault(const Constant(false))();
  BoolColumn get weeklySummaryEnabled =>
      boolean().withDefault(const Constant(true))();
  TextColumn get reminderTimesCsv =>
      text().withDefault(const Constant('08:00,20:00'))();

  // --- Reminders / reports (richer controls layered over the CSV above) ------
  BoolColumn get remindersEnabled =>
      boolean().withDefault(const Constant(true))();
  TextColumn get morningReminderTime =>
      text().withDefault(const Constant('08:00'))();
  TextColumn get eveningReminderTime =>
      text().withDefault(const Constant('20:00'))();
  BoolColumn get weeklyReportEnabled =>
      boolean().withDefault(const Constant(true))();

  // --- Streaks / progression -------------------------------------------------
  IntColumn get streakCount => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastActiveDate => dateTime().nullable()();

  /// The week the user is currently tracking (FK-ish pointer into Weeks).
  IntColumn get currentWeekId => integer().nullable()();

  /// Whether the 70% level-gating system is enforced.
  BoolColumn get levelSystemEnabled =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
