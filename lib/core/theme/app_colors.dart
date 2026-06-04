import 'package:flutter/material.dart';

/// Brand palette. The seed drives both light and dark Material 3 schemes.
abstract final class AppColors {
  static const Color seed = Color(0xFF4C8C7B); // calm teal-green

  // Timer phase accents (used by the session screen).
  static const Color squeeze = Color(0xFFE57373);
  static const Color hold = Color(0xFFFFB74D);
  static const Color release = Color(0xFF64B5F6);
  static const Color rest = Color(0xFF81C784);

  // Program phase accents (weeks carry phase 1..4).
  static const Color phase1 = Color(0xFF9575CD); // purple — Temel
  static const Color phase2 = Color(0xFF4DB6AC); // green  — Geliştirme
  static const Color phase3 = Color(0xFFFFB74D); // orange — Entegrasyon
  static const Color phase4 = Color(0xFFE57373); // red    — Otomasyon

  // Exercise type accents.
  static const Color kegel = Color(0xFF9575CD); // purple
  static const Color breath = Color(0xFF4DB6AC); // green
  static const Color mind = Color(0xFFFFB74D); // orange
  static const Color combo = Color(0xFFF06292); // pink
}
