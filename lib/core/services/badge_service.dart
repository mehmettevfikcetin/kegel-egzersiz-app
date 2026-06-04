import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../providers/core_providers.dart';
import '../utils/streak_calculator.dart';

final badgeServiceProvider = Provider<BadgeService>(
  (ref) => BadgeService(ref.watch(databaseProvider)),
);

/// Evaluates achievement triggers and unlocks any newly-earned badges.
///
/// [check] is idempotent — it only unlocks badges that are currently locked and
/// whose condition is now satisfied, and returns just those freshly-unlocked
/// badges so the UI can celebrate them. Call it every time a completion log is
/// saved (and after creating a custom program).
class BadgeService {
  BadgeService(this._db);

  final AppDatabase _db;

  Future<List<Badge>> check() async {
    final badges = await _db.badgeDao.watchBadges().first;
    final locked = {
      for (final b in badges)
        if (!b.isUnlocked) b.code: b,
    };
    if (locked.isEmpty) return const [];

    final earned = await _earnedCodes(locked.keys.toSet());

    final newlyUnlocked = <Badge>[];
    for (final code in earned) {
      final badge = locked[code];
      if (badge == null) continue;
      await _db.badgeDao.unlock(code);
      newlyUnlocked.add(badge);
    }
    return newlyUnlocked;
  }

  /// Returns the subset of [candidates] whose trigger is currently satisfied.
  /// Only computes the data each candidate actually needs.
  Future<Set<String>> _earnedCodes(Set<String> candidates) async {
    final earned = <String>{};

    final needsTotals = candidates.contains('first_session') ||
        candidates.contains('hundred_sessions');
    if (needsTotals) {
      final total = await _db.completionDao.totalSessions();
      if (total >= 1) earned.add('first_session');
      if (total >= 100) earned.add('hundred_sessions');
    }

    final needsStreak =
        candidates.contains('streak_7') || candidates.contains('streak_30');
    if (needsStreak) {
      final days = await _db.completionDao.completedDays();
      final streak = StreakCalculator.currentStreak(days);
      if (streak >= 7) earned.add('streak_7');
      if (streak >= 30) earned.add('streak_30');
    }

    const phaseCodes = {
      1: 'phase_1_complete',
      2: 'phase_2_complete',
      3: 'phase_3_complete',
      4: 'phase_4_complete',
    };
    final needsPhases = candidates.contains('program_complete') ||
        phaseCodes.values.any(candidates.contains);
    if (needsPhases) {
      final program = await _db.programDao.activeProgram();
      if (program != null) {
        final weeks = await _db.programDao.watchWeeks(program.id).first;
        if (weeks.isNotEmpty) {
          // Ratio per week (only weeks that actually have exercises count).
          final ratios = <int, double>{}; // weekId -> ratio
          for (final w in weeks) {
            ratios[w.id] = await _db.completionDao.weekCompletionRatio(w.id);
          }

          bool phaseDone(int phase) {
            final phaseWeeks = weeks.where((w) => w.phase == phase).toList();
            if (phaseWeeks.isEmpty) return false;
            return phaseWeeks.every((w) => (ratios[w.id] ?? 0) >= 1.0);
          }

          phaseCodes.forEach((phase, code) {
            if (candidates.contains(code) && phaseDone(phase)) earned.add(code);
          });

          if (candidates.contains('program_complete') &&
              weeks.every((w) => (ratios[w.id] ?? 0) >= 1.0)) {
            earned.add('program_complete');
          }
        }
      }
    }

    if (candidates.contains('custom_program')) {
      final customCount = await (_db.selectOnly(_db.programs)
            ..addColumns([_db.programs.id.count()])
            ..where(_db.programs.isBuiltIn.equals(false)))
          .map((row) => row.read(_db.programs.id.count()) ?? 0)
          .getSingle();
      if (customCount >= 1) earned.add('custom_program');
    }

    return earned;
  }
}
