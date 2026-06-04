import 'package:drift/drift.dart';

/// Achievement badge. `code` is a stable identifier used by the unlock logic;
/// title/description are seeded (Turkish) and rendered in the achievements grid.
class Badges extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();
  TextColumn get title => text()();
  TextColumn get description => text()();

  /// Name of the icon to render in the achievements grid (e.g. a Material icon
  /// key or asset name). Nullable so older seeds remain valid.
  TextColumn get iconName => text().nullable()();

  BoolColumn get isUnlocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get unlockedAt => dateTime().nullable()();
}
