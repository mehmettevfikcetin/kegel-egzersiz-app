import 'package:flutter/material.dart';

import '../database/tables/exercises.dart';
import 'app_colors.dart';

/// Custom theme colors exposed via [ThemeExtension] so widgets can read
/// program-phase, exercise-type and timer-phase accents through the theme
/// (`AppPalette.of(context)`) instead of hard-coding [AppColors].
///
/// The accents are deliberately brightness-agnostic (mid-tone, legible on both
/// light and dark surfaces), so `light`/`dark` currently share values — keeping
/// the factories lets us diverge later without touching call sites.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.phase1,
    required this.phase2,
    required this.phase3,
    required this.phase4,
    required this.kegel,
    required this.breath,
    required this.mind,
    required this.combo,
    required this.squeeze,
    required this.hold,
    required this.release,
    required this.rest,
  });

  final Color phase1;
  final Color phase2;
  final Color phase3;
  final Color phase4;

  final Color kegel;
  final Color breath;
  final Color mind;
  final Color combo;

  final Color squeeze;
  final Color hold;
  final Color release;
  final Color rest;

  static const AppPalette _shared = AppPalette(
    phase1: AppColors.phase1,
    phase2: AppColors.phase2,
    phase3: AppColors.phase3,
    phase4: AppColors.phase4,
    kegel: AppColors.kegel,
    breath: AppColors.breath,
    mind: AppColors.mind,
    combo: AppColors.combo,
    squeeze: AppColors.squeeze,
    hold: AppColors.hold,
    release: AppColors.release,
    rest: AppColors.rest,
  );

  factory AppPalette.light() => _shared;
  factory AppPalette.dark() => _shared;

  /// The accent for a 1-based program phase (weeks carry `phase` 1..4).
  Color phaseColor(int phase) => switch (phase) {
        1 => phase1,
        2 => phase2,
        3 => phase3,
        _ => phase4,
      };

  /// The accent for an exercise type.
  Color typeColor(ExerciseType type) => switch (type) {
        ExerciseType.kegel => kegel,
        ExerciseType.breath => breath,
        ExerciseType.mind => mind,
        ExerciseType.combo => combo,
      };

  /// Convenience accessor — the app always registers this extension.
  static AppPalette of(BuildContext context) =>
      Theme.of(context).extension<AppPalette>() ?? _shared;

  @override
  AppPalette copyWith({
    Color? phase1,
    Color? phase2,
    Color? phase3,
    Color? phase4,
    Color? kegel,
    Color? breath,
    Color? mind,
    Color? combo,
    Color? squeeze,
    Color? hold,
    Color? release,
    Color? rest,
  }) {
    return AppPalette(
      phase1: phase1 ?? this.phase1,
      phase2: phase2 ?? this.phase2,
      phase3: phase3 ?? this.phase3,
      phase4: phase4 ?? this.phase4,
      kegel: kegel ?? this.kegel,
      breath: breath ?? this.breath,
      mind: mind ?? this.mind,
      combo: combo ?? this.combo,
      squeeze: squeeze ?? this.squeeze,
      hold: hold ?? this.hold,
      release: release ?? this.release,
      rest: rest ?? this.rest,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      phase1: Color.lerp(phase1, other.phase1, t)!,
      phase2: Color.lerp(phase2, other.phase2, t)!,
      phase3: Color.lerp(phase3, other.phase3, t)!,
      phase4: Color.lerp(phase4, other.phase4, t)!,
      kegel: Color.lerp(kegel, other.kegel, t)!,
      breath: Color.lerp(breath, other.breath, t)!,
      mind: Color.lerp(mind, other.mind, t)!,
      combo: Color.lerp(combo, other.combo, t)!,
      squeeze: Color.lerp(squeeze, other.squeeze, t)!,
      hold: Color.lerp(hold, other.hold, t)!,
      release: Color.lerp(release, other.release, t)!,
      rest: Color.lerp(rest, other.rest, t)!,
    );
  }
}
