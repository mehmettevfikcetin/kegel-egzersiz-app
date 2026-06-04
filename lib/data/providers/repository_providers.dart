import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/core_providers.dart';
import '../repositories/badge_repository.dart';
import '../repositories/completion_log_repository.dart';
import '../repositories/exercise_repository.dart';
import '../repositories/program_repository.dart';
import '../repositories/settings_repository.dart';
import '../repositories/week_repository.dart';

/// Riverpod providers for the repository layer. Each reads the single
/// [databaseProvider] and wraps the relevant DAO(s). Existing DAO-direct
/// consumers keep working; new code can depend on these instead.

final programRepositoryProvider = Provider<ProgramRepository>(
  (ref) => ProgramRepository(ref.watch(databaseProvider)),
);

final weekRepositoryProvider = Provider<WeekRepository>(
  (ref) => WeekRepository(ref.watch(databaseProvider)),
);

final exerciseRepositoryProvider = Provider<ExerciseRepository>(
  (ref) => ExerciseRepository(ref.watch(databaseProvider)),
);

final completionLogRepositoryProvider = Provider<CompletionLogRepository>(
  (ref) => CompletionLogRepository(ref.watch(databaseProvider)),
);

final badgeRepositoryProvider = Provider<BadgeRepository>(
  (ref) => BadgeRepository(ref.watch(databaseProvider)),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(databaseProvider)),
);
