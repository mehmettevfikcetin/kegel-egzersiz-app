import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'notification_ids.dart';

/// Owns all local-notification setup, scheduling and tap routing.
///
/// Lives behind `notificationServiceProvider`. `init()` is awaited in `main()`.
class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Set by the app so a notification tap can deep-link via go_router.
  void Function(String route)? onSelectRoute;

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    // Timezone DB + device zone, so zonedSchedule fires at correct wall-clock.
    tzdata.initializeTimeZones();
    try {
      final dynamic local = await FlutterTimezone.getLocalTimezone();
      final String name = local is String ? local : local.identifier as String;
      tz.setLocalLocation(tz.getLocation(name));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('Europe/Istanbul'));
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (response) {
        final route = response.payload;
        if (route != null && route.isNotEmpty) onSelectRoute?.call(route);
      },
    );

    _initialized = true;
  }

  /// Android 13+ runtime notification permission. Returns true if granted.
  Future<bool> requestPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final granted = await android?.requestNotificationsPermission();
    return granted ?? true;
  }

  // --- Daily reminders -------------------------------------------------------

  static const _dailyDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      NotificationChannels.dailyReminders,
      'Günlük Hatırlatıcılar',
      channelDescription: 'Egzersiz setlerini hatırlatır',
      importance: Importance.high,
      priority: Priority.high,
    ),
  );

  /// Cancels every scheduled daily reminder slot.
  Future<void> cancelDailyReminders() async {
    for (final id in NotificationIds.allDailyReminderIds) {
      await _plugin.cancel(id: id);
    }
  }

  /// Fires an immediate notification so the user can confirm delivery works.
  Future<void> showTestNotification({
    required String title,
    required String body,
  }) =>
      _plugin.show(
        id: NotificationIds.testNotification,
        title: title,
        body: body,
        notificationDetails: _dailyDetails,
        payload: '/home',
      );

  /// Cancels existing reminder slots and reschedules from [times].
  Future<void> scheduleDailyReminders(
    List<TimeOfDay> times, {
    required String title,
    required String body,
  }) async {
    await cancelDailyReminders();
    for (var slot = 0;
        slot < times.length && slot < NotificationIds.maxDailyReminders;
        slot++) {
      await _plugin.zonedSchedule(
        id: NotificationIds.dailyReminder(slot),
        title: title,
        body: body,
        scheduledDate: _nextInstanceOfTime(times[slot]),
        notificationDetails: _dailyDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: '/home',
      );
    }
  }

  // --- Weekly summary --------------------------------------------------------

  static const _weeklyDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      NotificationChannels.weeklySummary,
      'Haftalık Özet',
      channelDescription: 'Pazar akşamı haftalık ilerleme özeti',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    ),
  );

  /// Schedules the next Sunday-evening summary. Body is computed by the caller
  /// (refreshed on app open) so stats are current; repeats weekly thereafter.
  Future<void> scheduleWeeklySummary({
    required String title,
    required String body,
    int hour = 20,
    int minute = 0,
  }) async {
    await _plugin.zonedSchedule(
      id: NotificationIds.weeklySummary,
      title: title,
      body: body,
      scheduledDate: _nextInstanceOfWeekday(DateTime.sunday, hour, minute),
      notificationDetails: _weeklyDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: '/progress',
    );
  }

  Future<void> cancelWeeklySummary() =>
      _plugin.cancel(id: NotificationIds.weeklySummary);

  // --- Helpers ---------------------------------------------------------------

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  tz.TZDateTime _nextInstanceOfWeekday(int weekday, int hour, int minute) {
    var scheduled = _nextInstanceOfTime(TimeOfDay(hour: hour, minute: minute));
    while (scheduled.weekday != weekday) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
