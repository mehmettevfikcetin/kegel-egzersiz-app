import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_database.dart';
import 'default_program.dart';

/// Populates the database on first launch (and on seed-version bumps).
///
/// Idempotent: gated by a stored `seedVersion`, and built-in rows are only
/// inserted if absent — user-created programs and all logs are never touched.
class SeedRunner {
  static const int currentSeedVersion = 3;
  static const String _prefsKey = 'seedVersion';

  final AppDatabase db;
  final SharedPreferences prefs;

  SeedRunner(this.db, this.prefs);

  Future<void> ensureSeeded() async {
    final stored = prefs.getInt(_prefsKey) ?? 0;
    if (stored >= currentSeedVersion) return;

    await db.transaction(() async {
      await _seedDefaultProgram();
      await _seedBadges();
      await _seedSettings();
    });

    await prefs.setInt(_prefsKey, currentSeedVersion);
  }

  Future<void> _seedDefaultProgram() async {
    final existing =
        await (db.select(db.programs)..where((t) => t.isBuiltIn.equals(true)))
            .get();
    if (existing.isNotEmpty) return;

    final programId = await db.into(db.programs).insert(ProgramsCompanion.insert(
          name: defaultProgram.name,
          description: Value(defaultProgram.description),
          isBuiltIn: const Value(true),
          isActive: const Value(true),
        ));

    for (final w in defaultProgram.weeks) {
      final weekId = await db.into(db.weeks).insert(WeeksCompanion.insert(
            programId: programId,
            weekIndex: w.weekIndex,
            phase: w.phase,
            title: Value(w.title),
            phaseName: Value(w.phaseName),
            unlockThreshold: Value(w.unlockThreshold),
            isUnlocked: Value(w.weekIndex == 1), // only week 1 starts unlocked
          ));

      var order = 0;
      for (final e in w.exercises) {
        await db.into(db.exercises).insert(ExercisesCompanion.insert(
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
  }

  /// Reconciles the badge catalogue to [seedBadges] without losing unlock
  /// state: removes badges whose `code` is no longer defined, refreshes the
  /// title/description/icon of existing ones (leaving `isUnlocked`/`unlockedAt`
  /// untouched), and inserts any new codes locked.
  Future<void> _seedBadges() async {
    final wanted = {for (final b in seedBadges) b.code: b};

    final existing = await db.select(db.badges).get();
    final existingCodes = {for (final b in existing) b.code};

    // Drop badges that are no longer part of the catalogue.
    for (final b in existing) {
      if (!wanted.containsKey(b.code)) {
        await (db.delete(db.badges)..where((t) => t.code.equals(b.code))).go();
      }
    }

    for (final b in seedBadges) {
      if (existingCodes.contains(b.code)) {
        // Refresh display fields only; preserve unlock state.
        await (db.update(db.badges)..where((t) => t.code.equals(b.code))).write(
          BadgesCompanion(
            title: Value(b.title),
            description: Value(b.description),
            iconName: Value(b.iconName),
          ),
        );
      } else {
        await db.into(db.badges).insert(
              BadgesCompanion.insert(
                code: b.code,
                title: b.title,
                description: b.description,
                iconName: Value(b.iconName),
              ),
              mode: InsertMode.insertOrIgnore, // `code` is unique
            );
      }
    }
  }

  Future<void> _seedSettings() async {
    final existing =
        await (db.select(db.appSettings)..where((t) => t.id.equals(0)))
            .getSingleOrNull();
    if (existing == null) {
      await db
          .into(db.appSettings)
          .insert(const AppSettingsCompanion(id: Value(0)));
    }
  }
}
