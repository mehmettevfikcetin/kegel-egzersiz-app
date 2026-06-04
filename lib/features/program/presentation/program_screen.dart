import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_retry.dart';

final activeProgramProvider = FutureProvider<Program?>(
  (ref) => ref.watch(databaseProvider).programDao.activeProgram(),
);

final programWeeksProvider =
    StreamProvider.family<List<Week>, int>((ref, programId) {
  return ref.watch(databaseProvider).programDao.watchWeeks(programId);
});

/// Phase → week list with lock badges. Week 1 is unlocked; later weeks unlock
/// at 70% completion of the previous week (or via force-unlock in settings).
class ProgramScreen extends ConsumerWidget {
  const ProgramScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final programAsync = ref.watch(activeProgramProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navProgram),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: l10n.commonEdit,
            onPressed: () => context.go('/program/editor'),
          ),
        ],
      ),
      body: programAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorRetry(
          onRetry: () => ref.invalidate(activeProgramProvider),
        ),
        data: (program) {
          if (program == null) {
            return EmptyState(
              icon: Icons.fitness_center,
              title: l10n.commonEmpty,
            );
          }
          final weeksAsync = ref.watch(programWeeksProvider(program.id));
          return weeksAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => ErrorRetry(
              onRetry: () => ref.invalidate(programWeeksProvider(program.id)),
            ),
            data: (weeks) => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: weeks.length,
              itemBuilder: (context, index) =>
                  _WeekTile(week: weeks[index], l10n: l10n),
            ),
          );
        },
      ),
    );
  }
}

class _WeekTile extends ConsumerWidget {
  const _WeekTile({required this.week, required this.l10n});

  final Week week;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${week.weekIndex}')),
        title: Text(l10n.programWeek(week.weekIndex)),
        subtitle: Text('${l10n.programPhase(week.phase)} · ${week.title ?? ''}'),
        trailing: week.isUnlocked
            ? const Icon(Icons.chevron_right)
            : const Icon(Icons.lock_outline),
        // A locked week stays tappable so it can offer force-unlock (works for
        // every program, including the built-in default shown here).
        onTap: week.isUnlocked
            ? () => context.go('/program/week/${week.id}')
            : () => _showForceUnlock(context, ref),
      ),
    );
  }

  Future<void> _showForceUnlock(BuildContext context, WidgetRef ref) async {
    final unlock = await showConfirmDialog(
      context,
      title: l10n.programForceUnlockTitle,
      message: l10n.programForceUnlockExplain,
      cancelLabel: l10n.commonCancel,
      confirmLabel: l10n.programForceUnlock,
      confirmColor: AppColors.hold,
    );
    if (unlock) {
      await ref
          .read(databaseProvider)
          .programDao
          .setWeekUnlocked(week.id, true);
    }
  }
}
