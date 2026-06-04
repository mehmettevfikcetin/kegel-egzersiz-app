import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/widgets/error_retry.dart';

/// Month calendar with markers on days that have completions; tapping a day
/// opens its session detail.
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final daysAsync = ref.watch(completedDaysProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navHistory)),
      body: daysAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorRetry(
          onRetry: () => ref.invalidate(completedDaysProvider),
        ),
        data: (completedDays) {
          final marked = completedDays
              .map((d) => DateTime(d.year, d.month, d.day))
              .toSet();
          return TableCalendar<void>(
            locale: 'tr_TR',
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: CalendarFormat.month,
            eventLoader: (day) =>
                marked.contains(DateTime(day.year, day.month, day.day))
                    ? const [null]
                    : const [],
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
              final iso = DateTime(selected.year, selected.month, selected.day)
                  .toIso8601String();
              context.go('/history/day/$iso');
            },
          );
        },
      ),
    );
  }
}
