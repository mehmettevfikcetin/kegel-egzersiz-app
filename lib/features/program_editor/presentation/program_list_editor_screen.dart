import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/services/badge_service.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/error_retry.dart';

final allProgramsProvider = StreamProvider<List<Program>>(
  (ref) => ref.watch(databaseProvider).programDao.watchPrograms(),
);

/// Lists built-in + custom programs. Tapping a program opens its editor; the
/// active program is highlighted. Custom programs can be deleted; the built-in
/// program is protected but can be reset to its shipped defaults.
class ProgramListEditorScreen extends ConsumerWidget {
  const ProgramListEditorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final programsAsync = ref.watch(allProgramsProvider);
    final dao = ref.read(databaseProvider).programDao;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navProgram),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'reset') _resetToDefault(context, ref);
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'reset',
                child: Text(l10n.programResetDefault),
              ),
            ],
          ),
        ],
      ),
      body: programsAsync.when(
        // Keep showing the existing list during the brief create/refresh
        // re-emit instead of flashing the (red) error/loading placeholder.
        skipLoadingOnReload: true,
        skipError: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorRetry(
          onRetry: () => ref.invalidate(allProgramsProvider),
        ),
        data: (programs) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: programs.length,
          itemBuilder: (context, index) {
            final p = programs[index];
            return Card(
              color: p.isActive
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
              child: ListTile(
                leading: Icon(
                    p.isActive ? Icons.check_circle : Icons.circle_outlined),
                title: Text(p.name),
                subtitle: Text(p.description ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (p.isActive)
                      Chip(
                        label: Text(l10n.programActiveChip),
                        visualDensity: VisualDensity.compact,
                      )
                    else
                      TextButton(
                        onPressed: () => dao.setActiveProgram(p.id),
                        child: Text(l10n.programActiveChip),
                      ),
                    if (p.isBuiltIn)
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(Icons.lock_outline),
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => dao.deleteProgram(p.id),
                      ),
                  ],
                ),
                onTap: () => context.go('/program/editor/${p.id}'),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: Text(l10n.programCreateNew),
        onPressed: () => _createProgram(context, ref),
      ),
    );
  }

  Future<void> _createProgram(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final name = await showNameInputDialog(
      context,
      title: l10n.programCreateNew,
      label: l10n.programNamePrompt,
      cancelLabel: l10n.commonCancel,
      confirmLabel: l10n.commonSave,
    );
    if (name == null || name.isEmpty) return;

    try {
      await ref.read(databaseProvider).programDao.createEmptyProgram(name);
      // Unlock any earned badge (e.g. "Kendi Programın") in the database, but do
      // NOT show the celebratory sheet here: its Hero + Confetti modal, mounted
      // while the list's drift stream re-emits, tore down the element tree out of
      // order and tripped the framework's `_dependents.isEmpty` assertion (the
      // error screen). Badges still surface on the achievements screen. We stay
      // on the list and the new program appears immediately via the stream.
      await ref.read(badgeServiceProvider).check();
      messenger.showSnackBar(
        SnackBar(content: Text('"$name" oluşturuldu')),
      );
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.errorGeneric)));
    }
  }

  Future<void> _resetToDefault(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showConfirmDialog(
      context,
      title: l10n.programResetDefault,
      message: l10n.programResetDefaultConfirm,
      cancelLabel: l10n.commonCancel,
      confirmLabel: l10n.commonReset,
    );
    if (ok) {
      await ref.read(databaseProvider).programDao.resetDefaultProgram();
    }
  }
}
