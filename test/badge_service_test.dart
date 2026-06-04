import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kegel_egzersiz_app/core/database/app_database.dart';
import 'package:kegel_egzersiz_app/core/database/tables/completion_logs.dart';
import 'package:kegel_egzersiz_app/core/services/badge_service.dart';

/// Seeds the badge catalogue the [BadgeService] checks against.
Future<void> _seedBadges(AppDatabase db) async {
  const codes = [
    'first_session',
    'streak_7',
    'streak_30',
    'phase_1_complete',
    'phase_2_complete',
    'phase_3_complete',
    'phase_4_complete',
    'program_complete',
    'custom_program',
    'hundred_sessions',
  ];
  for (final code in codes) {
    await db.into(db.badges).insert(
          BadgesCompanion.insert(code: code, title: code, description: code),
        );
  }
}

void main() {
  late AppDatabase db;
  late BadgeService service;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    service = BadgeService(db);
    await db.into(db.appSettings).insert(const AppSettingsCompanion(id: Value(0)));
    await _seedBadges(db);
  });

  tearDown(() => db.close());

  Future<int> seedSingleWeekProgram() async {
    final programId = await db.into(db.programs).insert(
          ProgramsCompanion.insert(
            name: 'Test',
            isBuiltIn: const Value(true),
            isActive: const Value(true),
          ),
        );
    final weekId = await db.into(db.weeks).insert(
          WeeksCompanion.insert(programId: programId, weekIndex: 1, phase: 1),
        );
    return db.into(db.exercises).insert(
          ExercisesCompanion.insert(
            weekId: weekId,
            name: 'Kegel',
            squeezeSeconds: 3,
            holdSeconds: 5,
            releaseSeconds: 3,
            restSeconds: 5,
            reps: 1,
          ),
        );
  }

  Set<String> codesOf(List<Badge> badges) => badges.map((b) => b.code).toSet();

  test('first completion unlocks first_session, phase + program complete',
      () async {
    final exerciseId = await seedSingleWeekProgram();
    final exercise = await db.programDao.exerciseById(exerciseId);

    await db.completionDao.logCompletion(
      CompletionLogsCompanion(
        exerciseId: Value(exerciseId),
        weekId: Value(exercise!.weekId),
        session: const Value(SessionType.morning),
      ),
    );

    final unlocked = await service.check();
    final codes = codesOf(unlocked);

    expect(codes, contains('first_session'));
    expect(codes, contains('phase_1_complete'));
    expect(codes, contains('program_complete')); // only one week, 100% done
    expect(codes, isNot(contains('streak_7')));
    expect(codes, isNot(contains('hundred_sessions')));
    expect(codes, isNot(contains('custom_program')));
  });

  test('check is idempotent — re-running unlocks nothing new', () async {
    final exerciseId = await seedSingleWeekProgram();
    final exercise = await db.programDao.exerciseById(exerciseId);
    await db.completionDao.logCompletion(
      CompletionLogsCompanion(
        exerciseId: Value(exerciseId),
        weekId: Value(exercise!.weekId),
        session: const Value(SessionType.morning),
      ),
    );

    final first = await service.check();
    expect(first, isNotEmpty);

    final second = await service.check();
    expect(second, isEmpty);
  });

  test('creating a custom program unlocks custom_program', () async {
    await seedSingleWeekProgram();
    // A non-built-in program represents a user customization.
    await db.into(db.programs).insert(
          ProgramsCompanion.insert(
            name: 'Custom',
            isBuiltIn: const Value(false),
          ),
        );

    final unlocked = await service.check();
    expect(codesOf(unlocked), contains('custom_program'));
  });
}
