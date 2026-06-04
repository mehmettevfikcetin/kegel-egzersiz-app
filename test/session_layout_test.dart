import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kegel_egzersiz_app/core/database/app_database.dart';
import 'package:kegel_egzersiz_app/core/localization/gen/app_localizations.dart';
import 'package:kegel_egzersiz_app/core/providers/core_providers.dart';
import 'package:kegel_egzersiz_app/features/exercise_session/presentation/session_screen.dart';
import 'package:drift/drift.dart' show Value;

Future<int> _seed(AppDatabase db) async {
  final programId = await db.into(db.programs).insert(
        ProgramsCompanion.insert(name: 'Test'),
      );
  final weekId = await db.into(db.weeks).insert(
        WeeksCompanion.insert(programId: programId, weekIndex: 1, phase: 1),
      );
  final exId = await db.into(db.exercises).insert(
        ExercisesCompanion.insert(
          weekId: weekId,
          name: 'Temel Kegel',
          squeezeSeconds: 3,
          holdSeconds: 5,
          releaseSeconds: 3,
          restSeconds: 10,
          reps: 10,
          sets: const Value(2),
        ),
      );
  return exId;
}

void main() {
  testWidgets('SessionScreen lays out without exceptions', (tester) async {
    tester.view.physicalSize = const Size(1170, 2532); // iPhone-ish
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final exId = await _seed(db);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          locale: const Locale('tr'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: SessionScreen(exerciseId: exId),
        ),
      ),
    );

    // Let initState's post-frame loadById run and the DB future resolve.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    expect(tester.takeException(), isNull,
        reason: 'timer screen must lay out without overflow/exceptions');

    // The ring countdown, the primary action and both secondary controls must
    // all be present (the overflow previously dropped the middle button).
    // Loaded-but-not-started, the primary button shows the Resume/Start label.
    expect(find.text('3'), findsOneWidget); // countdown
    expect(find.text('Devam Et'), findsOneWidget); // primary (start/resume)
    expect(find.text('İptal'), findsOneWidget); // exit
    expect(find.text('Atla'), findsOneWidget); // skip
  });
}
