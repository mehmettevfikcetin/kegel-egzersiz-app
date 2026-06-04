import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/widgets/error_retry.dart';

final weekExercisesProvider =
    StreamProvider.family<List<Exercise>, int>((ref, weekId) {
  return ref.watch(databaseProvider).programDao.watchExercises(weekId);
});

/// Exercises within a week, each launching the timer session.
class WeekDetailScreen extends ConsumerWidget {
  const WeekDetailScreen({super.key, required this.weekId});

  final int weekId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final exercisesAsync = ref.watch(weekExercisesProvider(weekId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProgram)),
      body: exercisesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorRetry(
          onRetry: () => ref.invalidate(weekExercisesProvider(weekId)),
        ),
        data: (exercises) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final ex in exercises)
              Card(
                child: ListTile(
                  title: Text(ex.name),
                  subtitle: Text(
                    '${ex.reps}× · kas ${ex.squeezeSeconds}s / tut ${ex.holdSeconds}s / '
                    'bırak ${ex.releaseSeconds}s / dinlen ${ex.restSeconds}s',
                  ),
                  trailing: const Icon(Icons.play_circle_fill),
                  onTap: () => context.push('/session/${ex.id}'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
