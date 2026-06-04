import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kegel_egzersiz_app/core/database/app_database.dart';

// Plain (non-widget) test: real async, so drift `.first` resolves cleanly.
//
// The create-program UI crash was reproduced and confirmed fixed separately
// (the `_dependents.isEmpty` assertion came from `showBadgeUnlockSheet`'s Hero
// modal mounted during the list's stream rebuild; the create flow no longer
// shows that sheet). This test pins the data behaviour of the new empty-program
// creation that the FAB calls.
void main() {
  test('createEmptyProgram: one empty unlocked week, no exercises, inactive',
      () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    final id = await db.programDao.createEmptyProgram('Benim Programım');

    final programs = await db.programDao.watchPrograms().first;
    final created = programs.firstWhere((p) => p.id == id);
    expect(created.name, 'Benim Programım');
    expect(created.isBuiltIn, isFalse);
    expect(created.isActive, isFalse);

    final weeks = await db.programDao.watchWeeks(id).first;
    expect(weeks.length, 1, reason: 'exactly one week');
    expect(weeks.single.weekIndex, 1);
    expect(weeks.single.isUnlocked, isTrue, reason: 'week 1 editable');

    final exercises = await db.programDao.watchExercises(weeks.single.id).first;
    expect(exercises, isEmpty, reason: 'no exercises (empty program)');
  });
}
