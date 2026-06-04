import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/badges.dart';

part 'badge_dao.g.dart';

@DriftAccessor(tables: [Badges])
class BadgeDao extends DatabaseAccessor<AppDatabase> with _$BadgeDaoMixin {
  BadgeDao(super.db);

  Stream<List<Badge>> watchBadges() => select(badges).watch();

  Future<void> unlock(String code) =>
      (update(badges)..where((t) => t.code.equals(code) & t.isUnlocked.equals(false)))
          .write(BadgesCompanion(
        isUnlocked: const Value(true),
        unlockedAt: Value(DateTime.now()),
      ));
}
