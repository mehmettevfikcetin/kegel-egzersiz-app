import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/app_database.dart';
import '../notifications/notification_service.dart';
import '../utils/audio_cues.dart';

/// Overridden in `main()` with the resolved instance (so the rest of the app
/// can read it synchronously).
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('Override sharedPreferencesProvider in main()'),
);

/// The single Drift database instance for the app's lifetime.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService(),
);

final audioCuesProvider = Provider<AudioCues>((ref) {
  final cues = AudioCues();
  ref.onDispose(cues.dispose);
  return cues;
});

/// Reactive user settings (theme, reminders, force-unlock, weekly summary).
final settingsProvider = StreamProvider<AppSetting>(
  (ref) => ref.watch(databaseProvider).watchSettings(),
);

/// Convenience: the days (date-only) that have at least one completion.
/// A reactive stream so the Home streak and Progress screen refresh the moment
/// a new completion log lands — no manual invalidation needed.
final completedDaysProvider = StreamProvider<List<DateTime>>(
  (ref) => ref.watch(databaseProvider).completionDao.watchCompletedDays(),
);
