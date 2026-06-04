import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/exercises.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';

/// Opens the bottom sheet to create (when [existing] is null) or edit an
/// exercise under [weekId]. [nextOrderIndex] is used as the order for new ones.
Future<void> showExerciseEditSheet(
  BuildContext context, {
  required int weekId,
  Exercise? existing,
  int nextOrderIndex = 0,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _ExerciseEditSheet(
      weekId: weekId,
      existing: existing,
      nextOrderIndex: nextOrderIndex,
    ),
  );
}

class _ExerciseEditSheet extends ConsumerStatefulWidget {
  const _ExerciseEditSheet({
    required this.weekId,
    required this.existing,
    required this.nextOrderIndex,
  });

  final int weekId;
  final Exercise? existing;
  final int nextOrderIndex;

  @override
  ConsumerState<_ExerciseEditSheet> createState() => _ExerciseEditSheetState();
}

class _ExerciseEditSheetState extends ConsumerState<_ExerciseEditSheet> {
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final List<TextEditingController> _steps;

  late ExerciseType _type;
  late int _sets;
  late int _reps;
  late double _hold;
  late double _rest;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?.name ?? '');
    _description = TextEditingController(text: e?.description ?? '');
    _steps = [
      for (final s in e?.steps ?? const <String>[])
        TextEditingController(text: s),
    ];
    _type = e?.type ?? ExerciseType.kegel;
    _sets = e?.sets ?? 1;
    _reps = e?.reps ?? 10;
    _hold = (e?.holdSeconds ?? 5).clamp(1, 30).toDouble();
    _rest = (e?.restSeconds ?? 5).clamp(1, 30).toDouble();
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    for (final c in _steps) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return;

    final dao = ref.read(databaseProvider).programDao;
    final steps = _steps
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    final description = _description.text.trim();

    final existing = widget.existing;
    if (existing == null) {
      await dao.insertExercise(ExercisesCompanion.insert(
        weekId: widget.weekId,
        name: name,
        orderIndex: Value(widget.nextOrderIndex),
        type: Value(_type),
        description: Value(description.isEmpty ? null : description),
        steps: Value(steps.isEmpty ? null : steps),
        squeezeSeconds: 2,
        holdSeconds: _hold.round(),
        releaseSeconds: 2,
        restSeconds: _rest.round(),
        reps: _reps,
        sets: Value(_sets),
      ));
    } else {
      await dao.updateExercise(existing.copyWith(
        name: name,
        type: _type,
        description: Value(description.isEmpty ? null : description),
        steps: Value(steps.isEmpty ? null : steps),
        holdSeconds: _hold.round(),
        restSeconds: _rest.round(),
        reps: _reps,
        sets: _sets,
      ));
    }
    if (mounted) Navigator.of(context).pop();
  }

  String _typeLabel(ExerciseType t, AppLocalizations l10n) => switch (t) {
        ExerciseType.kegel => l10n.exerciseTypeKegel,
        ExerciseType.breath => l10n.exerciseTypeBreath,
        ExerciseType.mind => l10n.exerciseTypeMind,
        ExerciseType.combo => l10n.exerciseTypeCombo,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottomInset),
      child: ListView(
        shrinkWrap: true,
        children: [
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: l10n.exerciseName),
          ),
          const SizedBox(height: 16),
          Text(l10n.exerciseType,
              style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          SegmentedButton<ExerciseType>(
            segments: [
              for (final t in ExerciseType.values)
                ButtonSegment(value: t, label: Text(_typeLabel(t, l10n))),
            ],
            selected: {_type},
            showSelectedIcon: false,
            onSelectionChanged: (s) => setState(() => _type = s.first),
          ),
          const SizedBox(height: 16),
          _Stepper(
            label: l10n.exerciseSets,
            value: _sets,
            onChanged: (v) => setState(() => _sets = v),
          ),
          _Stepper(
            label: l10n.exerciseReps,
            value: _reps,
            onChanged: (v) => setState(() => _reps = v),
          ),
          const SizedBox(height: 8),
          Text(l10n.exerciseHold(_hold.round())),
          Slider(
            value: _hold,
            min: 1,
            max: 30,
            divisions: 29,
            label: '${_hold.round()}',
            onChanged: (v) => setState(() => _hold = v),
          ),
          Text(l10n.exerciseRest(_rest.round())),
          Slider(
            value: _rest,
            min: 1,
            max: 30,
            divisions: 29,
            label: '${_rest.round()}',
            onChanged: (v) => setState(() => _rest = v),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _description,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.exerciseDescription,
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.exerciseSteps,
              style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          for (var i = 0; i < _steps.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _steps[i],
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: l10n.exerciseStepHint(i + 1),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => setState(() {
                      _steps.removeAt(i).dispose();
                    }),
                  ),
                ],
              ),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              icon: const Icon(Icons.add),
              label: Text(l10n.exerciseAddStep),
              onPressed: () =>
                  setState(() => _steps.add(TextEditingController())),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: _save, child: Text(l10n.commonSave)),
        ],
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: value > 1 ? () => onChanged(value - 1) : null,
        ),
        SizedBox(
          width: 32,
          child: Text('$value', textAlign: TextAlign.center),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () => onChanged(value + 1),
        ),
      ],
    );
  }
}
