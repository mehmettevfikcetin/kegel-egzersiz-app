import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';

const _kOnboardingCompletedKey = 'onboardingCompleted';

/// Whether the user has finished the first-launch onboarding. Seeded
/// synchronously from [sharedPreferencesProvider]; the router redirect watches
/// it to gate the app behind onboarding, and [complete] flips it through.
class OnboardingNotifier extends Notifier<bool> {
  @override
  bool build() =>
      ref.watch(sharedPreferencesProvider).getBool(_kOnboardingCompletedKey) ??
      false;

  /// Persists the completed flag and updates state so the router redirect
  /// re-runs and lets the user through to `/home`.
  Future<void> complete() async {
    await ref
        .read(sharedPreferencesProvider)
        .setBool(_kOnboardingCompletedKey, true);
    state = true;
  }
}

final onboardingCompletedProvider =
    NotifierProvider<OnboardingNotifier, bool>(OnboardingNotifier.new);
