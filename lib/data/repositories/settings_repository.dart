import 'package:drift/drift.dart';

import '../../core/database/app_database.dart';

/// Read/write surface for the single-row [AppSettings].
///
/// Wraps [AppDatabase]'s settings helpers and adds typed mutators for the
/// streak / reminder / level-system fields so callers don't hand-build
/// companions.
class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  Stream<AppSetting> watch() => _db.watchSettings();

  Future<AppSetting> get() => _db.getSettings();

  /// Apply an arbitrary set of changes to the settings row.
  Future<void> update(AppSettingsCompanion changes) =>
      _db.updateSettings(changes);

  // --- Streaks ---------------------------------------------------------------
  Future<void> setStreak({
    required int current,
    required int longest,
    DateTime? lastActiveDate,
  }) =>
      _db.updateSettings(AppSettingsCompanion(
        streakCount: Value(current),
        longestStreak: Value(longest),
        lastActiveDate: Value(lastActiveDate),
      ));

  // --- Progression -----------------------------------------------------------
  Future<void> setCurrentWeek(int? weekId) =>
      _db.updateSettings(AppSettingsCompanion(currentWeekId: Value(weekId)));

  Future<void> setLevelSystemEnabled(bool enabled) =>
      _db.updateSettings(AppSettingsCompanion(levelSystemEnabled: Value(enabled)));

  // --- Reminders / reports ---------------------------------------------------
  Future<void> setReminders({
    bool? enabled,
    String? morningTime,
    String? eveningTime,
    bool? weeklyReport,
  }) =>
      _db.updateSettings(AppSettingsCompanion(
        remindersEnabled:
            enabled == null ? const Value.absent() : Value(enabled),
        morningReminderTime:
            morningTime == null ? const Value.absent() : Value(morningTime),
        eveningReminderTime:
            eveningTime == null ? const Value.absent() : Value(eveningTime),
        weeklyReportEnabled:
            weeklyReport == null ? const Value.absent() : Value(weeklyReport),
      ));
}
