import 'package:flutter/material.dart';
import 'package:mood_tracker/constants/mood_sizes.dart';

import 'package:mood_tracker/features/mood_tracker/domain/enums/mood_type.dart';
import 'package:mood_tracker/constants/mood_colors.dart';
import 'package:mood_tracker/constants/mood_configs.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/painter/mood_face_painter.dart';

class MoodSelectorCard extends StatelessWidget {
  final MoodType mood;
  final bool isHorizontalScroll;
  final VoidCallback onTap;

  const MoodSelectorCard({
    super.key,
    required this.mood,
    required this.isHorizontalScroll,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = moodDisplayConfigs[mood]!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isHorizontalScroll ? MoodSizes.selectorCardWidth : null,
        margin: isHorizontalScroll
            ? const EdgeInsets.only(right: MoodSizes.selectorCardSpacing)
            : EdgeInsets.zero,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: MoodColors.cardBackground,
          borderRadius: BorderRadius.circular(MoodSizes.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(MoodSizes.cardShadowOpacity),
              blurRadius: MoodSizes.cardBlurRadius,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            // ignore: deprecated_member_use
            color: config.color.withOpacity(MoodSizes.selectorBorderOpacity),
            width: MoodSizes.cardBorderWidth,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CustomPaint(
                    painter: MoodFacePainter(mood: mood, animationValue: 0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              config.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: config.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
