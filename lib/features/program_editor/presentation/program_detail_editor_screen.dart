import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/exercises.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/error_retry.dart';
import '../../program/presentation/program_screen.dart' show programWeeksProvider;
import '../../program/presentation/week_detail_screen.dart'
    show weekExercisesProvider;
import 'exercise_edit_sheet.dart';

final _programByIdProvider = FutureProvider.family<Program?, int>((ref, id) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.programs)..where((t) => t.id.equals(id)))
      .getSingleOrNull();
});

/// Editable view of a program: accordion of weeks, each listing its exercises
/// with edit / delete / reorder, plus add-exercise and add-week actions.
class ProgramDetailEditorScreen extends ConsumerWidget {
  const ProgramDetailEditorScreen({super.key, required this.programId});

  final int programId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final programAsync = ref.watch(_programByIdProvider(programId));
    final weeksAsync = ref.watch(programWeeksProvider(programId));

    return Scaffold(
      appBar: AppBar(
        title: Text(programAsync.asData?.value?.name ?? l10n.navProgram),
      ),
      body: weeksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorRetry(
          onRetry: () => ref.invalidate(programWeeksProvider(programId)),
        ),
        data: (weeks) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final week in weeks) _WeekSection(week: week, l10n: l10n),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: Text(l10n.programAddWeek),
              onPressed: () => _addWeek(ref, weeks),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addWeek(WidgetRef ref, List<Week> weeks) async {
    final nextIndex = weeks.isEmpty ? 1 : weeks.last.weekIndex + 1;
    final phase = ((nextIndex - 1) ~/ 2) + 1;
    await ref.read(databaseProvider).programDao.insertWeek(
          WeeksCompanion.insert(
            programId: programId,
            weekIndex: nextIndex,
            phase: phase,
            isUnlocked: Value(nextIndex == 1),
          ),
        );
  }
}

class _WeekSection extends ConsumerWidget {
  const _WeekSection({required this.week, required this.l10n});

  final Week week;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtitle = '${l10n.programPhase(week.phase)} · ${week.title ?? ''}';

    if (!week.isUnlocked) {
      return Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('${week.weekIndex}')),
          title: Text(l10n.programWeek(week.weekIndex)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.lock_outline),
          onTap: () => _showForceUnlock(context, ref),
        ),
      );
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: CircleAvatar(child: Text('${week.weekIndex}')),
        title: Text(l10n.programWeek(week.weekIndex)),
        subtitle: Text(subtitle),
        childrenPadding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
        children: [
          _ExerciseList(week: week, l10n: l10n),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.add),
                label: Text(l10n.programAddExercise),
                onPressed: () => _addExercise(context, ref),
              ),
              TextButton.icon(
                icon: const Icon(Icons.delete_outline),
                label: Text(l10n.commonDelete),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () => _deleteWeek(context, ref),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _addExercise(BuildContext context, WidgetRef ref) async {
    final current =
        ref.read(weekExercisesProvider(week.id)).asData?.value ?? const [];
    await showExerciseEditSheet(
      context,
      weekId: week.id,
      nextOrderIndex: current.length,
    );
  }

  Future<void> _deleteWeek(BuildContext context, WidgetRef ref) async {
    final ok = await _confirm(context, l10n.programDeleteWeekConfirm);
    if (ok) await ref.read(databaseProvider).programDao.deleteWeek(week.id);
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

class _ExerciseList extends ConsumerWidget {
  const _ExerciseList({required this.week, required this.l10n});

  final Week week;
  final AppLocalizations l10n;

  String _dayLabel(DayPart d) => switch (d) {
        DayPart.morning => l10n.programDayMorning,
        DayPart.midday => l10n.programDayMidday,
        DayPart.evening => l10n.programDayEvening,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsync = ref.watch(weekExercisesProvider(week.id));
    return exercisesAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Text('$e'),
      data: (exercises) {
        if (exercises.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Text(l10n.commonEmpty),
          );
        }
        return ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) newIndex -= 1;
            final ids = exercises.map((e) => e.id).toList();
            final moved = ids.removeAt(oldIndex);
            ids.insert(newIndex, moved);
            ref.read(databaseProvider).programDao.reorderExercises(week.id, ids);
          },
          children: [
            for (var i = 0; i < exercises.length; i++)
              _ExerciseCard(
                key: ValueKey(exercises[i].id),
                index: i,
                exercise: exercises[i],
                dayLabel: _dayLabel(exercises[i].dayPart),
                nextOrderIndex: exercises.length,
                l10n: l10n,
              ),
          ],
        );
      },
    );
  }
}

class _ExerciseCard extends ConsumerWidget {
  const _ExerciseCard({
    super.key,
    required this.index,
    required this.exercise,
    required this.dayLabel,
    required this.nextOrderIndex,
    required this.l10n,
  });

  final int index;
  final Exercise exercise;
  final String dayLabel;
  final int nextOrderIndex;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: ListTile(
        title: Text(exercise.name),
        subtitle: Text(
          '$dayLabel · ${l10n.homeExerciseSummary(exercise.sets, exercise.reps)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: l10n.commonEdit,
              onPressed: () => showExerciseEditSheet(
                context,
                weekId: exercise.weekId,
                existing: exercise,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: l10n.commonDelete,
              onPressed: () => _delete(context, ref),
            ),
            ReorderableDragStartListener(
              index: index,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.drag_handle),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final ok = await _confirm(context, l10n.programDeleteExerciseConfirm);
    if (ok) {
      await ref.read(databaseProvider).programDao.deleteExercise(exercise.id);
    }
  }
}

Future<bool> _confirm(BuildContext context, String message) async {
  final l10n = AppLocalizations.of(context);
  return showConfirmDialog(
    context,
    message: message,
    cancelLabel: l10n.commonCancel,
    confirmLabel: l10n.commonDelete,
    confirmColor: Theme.of(context).colorScheme.error,
  );
}
