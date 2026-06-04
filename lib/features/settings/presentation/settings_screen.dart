import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/error_retry.dart';

final _packageInfoProvider =
    FutureProvider<PackageInfo>((ref) => PackageInfo.fromPlatform());

/// App settings: notifications, appearance, program controls and about.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settingsAsync = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorRetry(
          onRetry: () => ref.invalidate(settingsProvider),
        ),
        data: (s) => ListView(
          children: [
            // --- Notifications ---
            _SectionHeader(l10n.settingsNotifications),
            _ReminderTile(
              title: l10n.settingsMorningReminder,
              time: _parseTime(s.morningReminderTime),
              onToggle: (on) => _setReminder(ref, l10n, morning: true, on: on),
              onPick: (t) =>
                  _setReminder(ref, l10n, morning: true, on: true, time: t),
            ),
            _ReminderTile(
              title: l10n.settingsEveningReminder,
              time: _parseTime(s.eveningReminderTime),
              onToggle: (on) => _setReminder(ref, l10n, morning: false, on: on),
              onPick: (t) =>
                  _setReminder(ref, l10n, morning: false, on: true, time: t),
            ),
            SwitchListTile(
              title: Text(l10n.settingsWeeklySummary),
              subtitle: Text(l10n.settingsWeeklySummaryHint),
              value: s.weeklyReportEnabled,
              onChanged: (v) => _setWeeklySummary(ref, l10n, v),
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active_outlined),
              title: Text(l10n.settingsTestNotification),
              onTap: () => _sendTest(context, ref, l10n),
            ),

            // --- Appearance ---
            _SectionHeader(l10n.settingsAppearance),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment(
                      value: ThemeMode.system,
                      label: Text(l10n.settingsThemeSystem)),
                  ButtonSegment(
                      value: ThemeMode.light,
                      label: Text(l10n.settingsThemeLight)),
                  ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text(l10n.settingsThemeDark)),
                ],
                selected: {s.themeMode},
                showSelectedIcon: false,
                onSelectionChanged: (sel) => ref
                    .read(databaseProvider)
                    .updateSettings(
                        AppSettingsCompanion(themeMode: Value(sel.first))),
              ),
            ),

            // --- Program ---
            _SectionHeader(l10n.settingsProgramSection),
            SwitchListTile(
              title: Text(l10n.settingsLevelSystem),
              subtitle: Text(l10n.settingsLevelSystemHint),
              value: s.levelSystemEnabled,
              onChanged: (v) => ref.read(databaseProvider).updateSettings(
                  AppSettingsCompanion(levelSystemEnabled: Value(v))),
            ),
            ListTile(
              leading: const Icon(Icons.restart_alt),
              title: Text(l10n.settingsResetProgress),
              onTap: () => _resetProgress(context, ref, l10n),
            ),
            ListTile(
              leading: Icon(Icons.delete_forever,
                  color: Theme.of(context).colorScheme.error),
              title: Text(l10n.settingsDeleteAll,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () => _deleteAll(context, ref, l10n),
            ),

            // --- About ---
            _SectionHeader(l10n.settingsAbout),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(l10n.settingsVersion),
              subtitle: Consumer(
                builder: (context, ref, _) {
                  final info = ref.watch(_packageInfoProvider);
                  return Text(info.asData == null
                      ? '…'
                      : '${info.asData!.value.version}+${info.asData!.value.buildNumber}');
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: Text(l10n.settingsHowToUse),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/guide'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // --- Reminders -------------------------------------------------------------

  /// Persists the morning/evening reminder times (empty string = off) and
  /// reschedules all daily notifications from the enabled ones.
  Future<void> _setReminder(
    WidgetRef ref,
    AppLocalizations l10n, {
    required bool morning,
    required bool on,
    TimeOfDay? time,
  }) async {
    final db = ref.read(databaseProvider);
    final current = await db.getSettings();
    final value = on ? _format(time ?? const TimeOfDay(hour: 8, minute: 0)) : '';

    await db.updateSettings(morning
        ? AppSettingsCompanion(morningReminderTime: Value(value))
        : AppSettingsCompanion(eveningReminderTime: Value(value)));

    final morningStr = morning ? value : current.morningReminderTime;
    final eveningStr = morning ? current.eveningReminderTime : value;
    final times = [
      for (final s in [morningStr, eveningStr])
        if (_parseTime(s) != null) _parseTime(s)!,
    ];

    final anyOn = times.isNotEmpty;
    await db.updateSettings(AppSettingsCompanion(remindersEnabled: Value(anyOn)));
    await ref.read(notificationServiceProvider).scheduleDailyReminders(
          times,
          title: l10n.remindersDailyTitle,
          body: l10n.remindersDailyBody,
        );
  }

  Future<void> _setWeeklySummary(
      WidgetRef ref, AppLocalizations l10n, bool enabled) async {
    final db = ref.read(databaseProvider);
    await db.updateSettings(
        AppSettingsCompanion(weeklyReportEnabled: Value(enabled)));
    final notif = ref.read(notificationServiceProvider);
    if (enabled) {
      final now = DateTime.now();
      final logs = await db.completionDao
          .watchLogsBetween(now.subtract(const Duration(days: 7)), now)
          .first;
      await notif.scheduleWeeklySummary(
        title: l10n.weeklySummaryTitle,
        body: l10n.weeklySummaryBody(logs.length),
      );
    } else {
      await notif.cancelWeeklySummary();
    }
  }

  Future<void> _sendTest(
      BuildContext context, WidgetRef ref, AppLocalizations l10n) async {
    final notif = ref.read(notificationServiceProvider);
    await notif.requestPermissions();
    await notif.showTestNotification(
      title: l10n.testNotificationTitle,
      body: l10n.testNotificationBody,
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.settingsTestSent)));
    }
  }

  // --- Destructive -----------------------------------------------------------

  Future<void> _resetProgress(
      BuildContext context, WidgetRef ref, AppLocalizations l10n) async {
    final ok = await showConfirmDialog(
      context,
      title: l10n.settingsResetProgress,
      message: l10n.settingsResetProgressConfirm,
      cancelLabel: l10n.commonCancel,
      confirmLabel: l10n.commonReset,
      confirmColor: Theme.of(context).colorScheme.error,
    );
    if (ok) await ref.read(databaseProvider).completionDao.clearAllLogs();
  }

  Future<void> _deleteAll(
      BuildContext context, WidgetRef ref, AppLocalizations l10n) async {
    final first = await showConfirmDialog(
      context,
      title: l10n.settingsDeleteAll,
      message: l10n.settingsDeleteAllConfirm1,
      cancelLabel: l10n.commonCancel,
      confirmLabel: l10n.commonContinue,
      confirmColor: Theme.of(context).colorScheme.error,
    );
    if (!first || !context.mounted) return;
    final second = await showConfirmDialog(
      context,
      title: l10n.settingsDeleteAll,
      message: l10n.settingsDeleteAllConfirm2,
      cancelLabel: l10n.commonCancel,
      confirmLabel: l10n.commonDelete,
      confirmColor: Theme.of(context).colorScheme.error,
    );
    if (second) await ref.read(databaseProvider).wipeAllData();
  }
}

TimeOfDay? _parseTime(String s) {
  final parts = s.split(':');
  if (parts.length != 2) return null;
  final h = int.tryParse(parts[0]);
  final m = int.tryParse(parts[1]);
  if (h == null || m == null) return null;
  return TimeOfDay(hour: h, minute: m);
}

String _format(TimeOfDay t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({
    required this.title,
    required this.time,
    required this.onToggle,
    required this.onPick,
  });

  final String title;
  final TimeOfDay? time;
  final ValueChanged<bool> onToggle;
  final ValueChanged<TimeOfDay> onPick;

  @override
  Widget build(BuildContext context) {
    final on = time != null;
    return SwitchListTile(
      title: Text(title),
      subtitle: on ? Text(time!.format(context)) : null,
      value: on,
      onChanged: onToggle,
      secondary: IconButton(
        icon: const Icon(Icons.schedule),
        onPressed: !on
            ? null
            : () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: time!,
                );
                if (picked != null) onPick(picked);
              },
      ),
    );
  }
}
