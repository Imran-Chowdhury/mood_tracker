import 'package:flutter/material.dart';
import 'package:mood_tracker/constants/mood_sizes.dart';
import 'package:mood_tracker/features/mood_tracker/domain/entity/mood_entity.dart';
import 'package:mood_tracker/constants/mood_colors.dart';
import 'package:mood_tracker/constants/mood_configs.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/widgets/animated_mood_face.dart';

class MoodHistoryItem extends StatelessWidget {
  final int index;
  final MoodEntry entry;
  final bool isMobile;
  final ValueNotifier<int?> animatedIndexNotifier;
  final VoidCallback onTap;

  const MoodHistoryItem({
    super.key,
    required this.index,
    required this.entry,
    required this.isMobile,
    required this.animatedIndexNotifier,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = moodDisplayConfigs[entry.mood]!;
    final cardWidth = isMobile
        ? MoodSizes.mobileEntryCardWidth
        : MoodSizes.desktopEntryCardWidth;
    final faceSize = isMobile
        ? MoodSizes.mobileFaceSize
        : MoodSizes.desktopFaceSize;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.only(right: MoodSizes.entryCardSpacing),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
            color: config.color.withOpacity(MoodSizes.cardBorderOpacity),
            width: MoodSizes.cardBorderWidth,
          ),
        ),
        // ValueListenableBuilder scopes rebuilds to this card only.
        // Changing animatedIndexNotifier.value does not trigger the parent
        // ListView or any sibling card to rebuild.
        child: ValueListenableBuilder<int?>(
          valueListenable: animatedIndexNotifier,
          builder: (_, animatingIdx, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: faceSize,
                  height: faceSize,
                  child: AnimatedMoodFace(
                    mood: entry.mood,
                    isAnimating: animatingIdx == index,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  config.label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: config.color,
                    fontSize: isMobile ? 13 : 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDate(entry.date),
                  style: const TextStyle(
                    color: MoodColors.subtitleText,
                    fontSize: 11,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }
}
