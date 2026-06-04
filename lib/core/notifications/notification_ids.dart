/// Stable notification ID allocation so reschedules cancel/replace cleanly.
///
/// - Daily reminders occupy the [dailyReminderBase] .. +[maxDailyReminders] band,
///   one ID per configured time slot.
/// - The weekly summary uses a single fixed ID.
abstract final class NotificationIds {
  static const int weeklySummary = 1000;

  /// One-off "test notification" fired from settings.
  static const int testNotification = 2000;

  static const int dailyReminderBase = 100;
  static const int maxDailyReminders = 10;

  static int dailyReminder(int slot) => dailyReminderBase + slot;

  static Iterable<int> get allDailyReminderIds =>
      List.generate(maxDailyReminders, (i) => dailyReminderBase + i);
}

/// Channel identifiers — must stay stable once shipped.
abstract final class NotificationChannels {
  static const String dailyReminders = 'daily_reminders';
  static const String weeklySummary = 'weekly_summary';
}
