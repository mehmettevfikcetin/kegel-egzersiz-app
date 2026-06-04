import 'package:flutter/material.dart';

/// Maps a badge's stored `iconName` (a Material icon key from the seed) to an
/// [IconData]. Falls back to a trophy so an unknown key still renders.
IconData badgeIcon(String? name) => switch (name) {
      'flag' => Icons.flag,
      'whatshot' => Icons.whatshot,
      'calendar_month' => Icons.calendar_month,
      'looks_one' => Icons.looks_one,
      'looks_two' => Icons.looks_two,
      'looks_3' => Icons.looks_3,
      'looks_4' => Icons.looks_4,
      'emoji_events' => Icons.emoji_events,
      'edit' => Icons.edit,
      'military_tech' => Icons.military_tech,
      'local_fire_department' => Icons.local_fire_department,
      'calendar_view_week' => Icons.calendar_view_week,
      'check_circle' => Icons.check_circle,
      'workspace_premium' => Icons.workspace_premium,
      _ => Icons.emoji_events,
    };
