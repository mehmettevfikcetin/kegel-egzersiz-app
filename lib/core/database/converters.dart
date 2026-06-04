import 'dart:convert';

import 'package:drift/drift.dart';

/// Stores a `List<String>` (e.g. an exercise's step-by-step instructions) as a
/// JSON text column. Drift has no native list column, so the value round-trips
/// through `jsonEncode`/`jsonDecode`. A null DB value is handled by Drift before
/// this converter runs (the column is `.nullable()`).
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    final decoded = jsonDecode(fromDb);
    return (decoded as List).map((e) => e as String).toList();
  }

  @override
  String toSql(List<String> value) => jsonEncode(value);
}
