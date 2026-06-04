import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/database/app_database.dart';
import 'core/database/seed/seed_runner.dart';
import 'core/notifications/notification_service.dart';
import 'core/providers/core_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Safety net: if a (debug-only) framework assertion fires mid build/transition,
  // show a neutral placeholder instead of a full-screen red/corrupted page. The
  // real triggers are removed elsewhere; this just keeps a stray error graceful.
  ErrorWidget.builder = (details) => Material(
        color: const Color(0xFF263238),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Bir şeyler ters gitti. Lütfen geri dönüp tekrar deneyin.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ),
      );

  // Turkish date/number formatting for intl (DateFormat('tr_TR'), table_calendar).
  await initializeDateFormatting('tr_TR');

  final prefs = await SharedPreferences.getInstance();
  final db = AppDatabase();

  // First-launch seed: default 8-week program, badges, settings.
  await SeedRunner(db, prefs).ensureSeeded();

  final notifications = NotificationService();
  await notifications.init();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        databaseProvider.overrideWithValue(db),
        notificationServiceProvider.overrideWithValue(notifications),
      ],
      child: const KegelApp(),
    ),
  );
}
