import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
// ThemeMode is used as a textEnum column type by AppSettings; the generated
// code in app_database.g.dart needs it in scope here.
import 'package:flutter/material.dart' show ThemeMode;

import 'converters.dart';
import 'daos/badge_dao.dart';
import 'daos/completion_dao.dart';
import 'daos/program_dao.dart';
import 'tables/app_settings.dart';
import 'tables/badges.dart';
import 'tables/completion_logs.dart';
import 'tables/exercises.dart';
import 'tables/programs.dart';
import 'tables/weeks.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Programs, Weeks, Exercises, CompletionLogs, Badges, AppSettings],
  daos: [ProgramDao, CompletionDao, BadgeDao],
)
class AppDatabase extends _$AppDatabase {
  /// Pass a custom [executor] in tests (e.g. `NativeDatabase.memory()`).
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'kegel_db'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // v2: additive columns on Exercises, Weeks, AppSettings, Badges.
          // (CompletionLogs.session gained `midday`, but it's a text enum value
          //  with no schema change.) All new columns have defaults / are
          //  nullable, so existing rows upgrade without data loss.
          if (from < 2) {
            await m.addColumn(exercises, exercises.dayPart);
            await m.addColumn(exercises, exercises.type);
            await m.addColumn(exercises, exercises.description);
            await m.addColumn(exercises, exercises.steps);

            await m.addColumn(weeks, weeks.phaseName);
            await m.addColumn(weeks, weeks.unlockThreshold);

            await m.addColumn(appSettings, appSettings.remindersEnabled);
            await m.addColumn(appSettings, appSettings.morningReminderTime);
            await m.addColumn(appSettings, appSettings.eveningReminderTime);
            await m.addColumn(appSettings, appSettings.weeklyReportEnabled);
            await m.addColumn(appSettings, appSettings.streakCount);
            await m.addColumn(appSettings, appSettings.longestStreak);
            await m.addColumn(appSettings, appSettings.lastActiveDate);
            await m.addColumn(appSettings, appSettings.currentWeekId);
            await m.addColumn(appSettings, appSettings.levelSystemEnabled);

            await m.addColumn(badges, badges.iconName);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  // --- Settings (single-row) -------------------------------------------------

  Stream<AppSetting> watchSettings() =>
      (select(appSettings)..where((t) => t.id.equals(0))).watchSingle();

  Future<AppSetting> getSettings() =>
      (select(appSettings)..where((t) => t.id.equals(0))).getSingle();

  Future<void> updateSettings(AppSettingsCompanion changes) =>
      (update(appSettings)..where((t) => t.id.equals(0))).write(changes);

  // --- Destructive: full data wipe ------------------------------------------

  /// Clears all logs, deletes user-created programs, re-locks every badge and
  /// resets streak/progression state. The built-in program is preserved.
  /// Drives "Tüm Verileri Sil" in settings.
  Future<void> wipeAllData() => transaction(() async {
        await delete(completionLogs).go();
        await (delete(programs)..where((t) => t.isBuiltIn.equals(false))).go();
        await update(badges).write(const BadgesCompanion(
          isUnlocked: Value(false),
          unlockedAt: Value(null),
        ));
        await (update(appSettings)..where((t) => t.id.equals(0))).write(
          const AppSettingsCompanion(
            streakCount: Value(0),
            longestStreak: Value(0),
            lastActiveDate: Value(null),
            currentWeekId: Value(null),
          ),
        );
      });
}
