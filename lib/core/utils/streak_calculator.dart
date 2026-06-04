/// Pure streak logic, isolated for easy unit testing.
///
/// Given the set of calendar days that have at least one completion, returns
/// the current consecutive-day streak ending today (or yesterday — a streak
/// is not yet broken until a full day with no activity passes).
abstract final class StreakCalculator {
  static int currentStreak(Iterable<DateTime> completedDays, {DateTime? now}) {
    final today = _dateOnly(now ?? DateTime.now());
    final days = completedDays.map(_dateOnly).toSet();
    if (days.isEmpty) return 0;

    // Anchor: today if active, else yesterday (grace period), else 0.
    var cursor = today;
    if (!days.contains(cursor)) {
      cursor = today.subtract(const Duration(days: 1));
      if (!days.contains(cursor)) return 0;
    }

    var streak = 0;
    while (days.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  /// Longest consecutive-day run ever recorded across [completedDays]. Pure
  /// function over the set of active days, independent of "today".
  static int longestStreak(Iterable<DateTime> completedDays) {
    final days = completedDays.map(_dateOnly).toSet();
    if (days.isEmpty) return 0;

    var longest = 0;
    for (final day in days) {
      // Only count a run from its first day (no predecessor) to avoid
      // recounting the same run from each of its members.
      if (days.contains(day.subtract(const Duration(days: 1)))) continue;
      var run = 0;
      var cursor = day;
      while (days.contains(cursor)) {
        run++;
        cursor = cursor.add(const Duration(days: 1));
      }
      if (run > longest) longest = run;
    }
    return longest;
  }

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
}
