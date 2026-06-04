import 'package:confetti/confetti.dart';
// Hide Material's Badge widget — we use the Drift `Badge` data class here.
import 'package:flutter/material.dart' hide Badge;

import '../../../core/database/app_database.dart';
import '../../../core/localization/gen/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import 'badge_icons.dart';

/// Presents a celebratory bottom sheet for one or more freshly-unlocked
/// [badges]: confetti burst + a scale-and-glow badge medallion. Safe to await;
/// returns when the user dismisses it.
Future<void> showBadgeUnlockSheet(
  BuildContext context,
  List<Badge> badges,
) {
  if (badges.isEmpty) return Future.value();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _BadgeUnlockSheet(badges: badges),
  );
}

class _BadgeUnlockSheet extends StatefulWidget {
  const _BadgeUnlockSheet({required this.badges});

  final List<Badge> badges;

  @override
  State<_BadgeUnlockSheet> createState() => _BadgeUnlockSheetState();
}

class _BadgeUnlockSheetState extends State<_BadgeUnlockSheet> {
  late final ConfettiController _confetti =
      ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _confetti.play());
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.badgeUnlockedTitle,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              for (final badge in widget.badges) ...[
                _BadgeMedallion(badge: badge),
                const SizedBox(height: 12),
                Text(
                  badge.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  badge.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
              FilledButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: Text(l10n.commonClose),
              ),
            ],
          ),
        ),
        ConfettiWidget(
          confettiController: _confetti,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          emissionFrequency: 0.05,
          numberOfParticles: 24,
          gravity: 0.25,
          colors: const [
            AppColors.phase1,
            AppColors.phase2,
            AppColors.phase3,
            AppColors.phase4,
          ],
        ),
      ],
    );
  }
}

/// The badge icon on a circle that scales in with an animated glow.
class _BadgeMedallion extends StatelessWidget {
  const _BadgeMedallion({required this.badge});

  final Badge badge;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 700),
      curve: Curves.elasticOut,
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        final glow = value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: value,
          child: Hero(
            tag: 'badge-${badge.code}',
            child: Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.45 * glow),
                    blurRadius: 28 * glow,
                    spreadRadius: 4 * glow,
                  ),
                ],
              ),
              child: Icon(badgeIcon(badge.iconName), size: 52, color: color),
            ),
          ),
        );
      },
    );
  }
}
