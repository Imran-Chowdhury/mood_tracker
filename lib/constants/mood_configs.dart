import 'package:flutter/material.dart';
import 'package:mood_tracker/features/mood_tracker/domain/enums/mood_type.dart';

import 'mood_colors.dart';

class MoodDisplayConfig {
  final String label;
  final Color color;

  const MoodDisplayConfig({required this.label, required this.color});
}

const Map<MoodType, MoodDisplayConfig> moodDisplayConfigs = {
  MoodType.happy: MoodDisplayConfig(label: 'Happy', color: MoodColors.happy),
  MoodType.neutral: MoodDisplayConfig(
    label: 'Neutral',
    color: MoodColors.neutral,
  ),
  MoodType.sad: MoodDisplayConfig(label: 'Sad', color: MoodColors.sad),
  MoodType.angry: MoodDisplayConfig(label: 'Angry', color: MoodColors.angry),
};
