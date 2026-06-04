import 'package:flutter_test/flutter_test.dart';
import 'package:kegel_egzersiz_app/core/utils/streak_calculator.dart';

void main() {
  final now = DateTime(2026, 6, 3); // fixed "today"
  DateTime daysAgo(int n) => now.subtract(Duration(days: n));

  group('StreakCalculator.currentStreak', () {
    test('no completions => 0', () {
      expect(StreakCalculator.currentStreak(const [], now: now), 0);
    });

    test('today only => 1', () {
      expect(StreakCalculator.currentStreak([daysAgo(0)], now: now), 1);
    });

    test('consecutive days ending today', () {
      final days = [daysAgo(0), daysAgo(1), daysAgo(2)];
      expect(StreakCalculator.currentStreak(days, now: now), 3);
    });

    test('grace period: streak ending yesterday still counts', () {
      final days = [daysAgo(1), daysAgo(2)];
      expect(StreakCalculator.currentStreak(days, now: now), 2);
    });

    test('broken streak (gap of two days) => 0', () {
      final days = [daysAgo(2), daysAgo(3)];
      expect(StreakCalculator.currentStreak(days, now: now), 0);
    });

    test('duplicate same-day entries collapse', () {
      final days = [daysAgo(0), daysAgo(0), daysAgo(1)];
      expect(StreakCalculator.currentStreak(days, now: now), 2);
    });
  });
}
