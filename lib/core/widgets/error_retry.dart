import 'package:flutter/material.dart';

import '../localization/gen/app_localizations.dart';

/// A centered error placeholder with a retry button — drop-in for the
/// `error:` branch of an async `.when(...)`. Pass [onRetry] (typically
/// `() => ref.invalidate(provider)`) to let the user recover.
class ErrorRetry extends StatelessWidget {
  const ErrorRetry({
    super.key,
    this.message,
    required this.onRetry,
  });

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 56, color: scheme.error),
            const SizedBox(height: 16),
            Text(
              message ?? l10n.errorGeneric,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 20),
            FilledButton.tonalIcon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.errorRetry),
            ),
          ],
        ),
      ),
    );
  }
}
