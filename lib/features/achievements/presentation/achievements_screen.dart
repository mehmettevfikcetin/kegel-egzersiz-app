// Hide Material's Badge widget — we use the Drift `Badge` data class here.
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/widgets/error_retry.dart';
import '../../../core/widgets/skeleton.dart';
import 'badge_icons.dart';

final badgesProvider = StreamProvider<List<Badge>>(
  (ref) => ref.watch(databaseProvider).badgeDao.watchBadges(),
);

/// Grid of the 10 achievement badges (locked vs unlocked).
class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final badgesAsync = ref.watch(badgesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.achievementsTitle)),
      body: badgesAsync.when(
        loading: () => const SkeletonList(itemCount: 6, itemHeight: 120),
        error: (e, _) => ErrorRetry(
          onRetry: () => ref.invalidate(badgesProvider),
        ),
        data: (badges) => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: badges.length,
          itemBuilder: (context, index) {
            final badge = badges[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'badge-${badge.code}',
                      child: Icon(
                        badge.isUnlocked
                            ? badgeIcon(badge.iconName)
                            : Icons.lock_outline,
                        size: 40,
                        color: badge.isUnlocked
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).disabledColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(badge.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      badge.isUnlocked
                          ? badge.description
                          : l10n.achievementLocked,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
