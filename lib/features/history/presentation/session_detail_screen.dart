import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/completion_logs.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_retry.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../data/providers/repository_providers.dart';

final dayLogsProvider =
    StreamProvider.family<List<CompletionLog>, DateTime>((ref, day) {
  return ref.watch(databaseProvider).completionDao.watchLogsForDay(day);
});

/// All logged sessions (and editable notes) for a single calendar day.
class SessionDetailScreen extends ConsumerWidget {
  const SessionDetailScreen({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final logsAsync = ref.watch(dayLogsProvider(date));
    final dateLabel = DateFormat.yMMMMEEEEd('tr_TR').format(date);

    return Scaffold(
      appBar: AppBar(title: Text(dateLabel)),
      body: logsAsync.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorRetry(
          onRetry: () => ref.invalidate(dayLogsProvider(date)),
        ),
        data: (logs) {
          if (logs.isEmpty) {
            return EmptyState(
              icon: Icons.event_busy_outlined,
              title: l10n.commonEmpty,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: logs.length,
            itemBuilder: (context, index) => _LogCard(log: logs[index]),
          );
        },
      ),
    );
  }
}

/// A single completion with its time/duration summary and an editable note.
class _LogCard extends ConsumerStatefulWidget {
  const _LogCard({required this.log});

  final CompletionLog log;

  @override
  ConsumerState<_LogCard> createState() => _LogCardState();
}

class _LogCardState extends ConsumerState<_LogCard> {
  late final TextEditingController _note =
      TextEditingController(text: widget.log.note ?? '');

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final text = _note.text.trim();
    await ref
        .read(completionLogRepositoryProvider)
        .updateNote(widget.log.id, text.isEmpty ? null : text);
    if (!mounted) return;
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).commonSave)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final log = widget.log;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: Icon(log.session == SessionType.morning
                  ? Icons.wb_sunny_outlined
                  : log.session == SessionType.midday
                      ? Icons.wb_twilight_outlined
                      : Icons.nightlight_outlined),
              title: Text(DateFormat.Hm('tr_TR').format(log.completedAt)),
              trailing: log.durationSeconds == null
                  ? null
                  : Text('${log.durationSeconds}s'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: _note,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: l10n.sessionNoteHint,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save_outlined),
                label: Text(l10n.commonSave),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
