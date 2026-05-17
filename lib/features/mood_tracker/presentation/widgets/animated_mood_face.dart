import 'package:flutter/material.dart';
import 'package:mood_tracker/features/mood_tracker/domain/enums/mood_type.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/painter/mood_face_painter.dart';

class AnimatedMoodFace extends StatelessWidget {
  final MoodType mood;
  final bool isAnimating;

  const AnimatedMoodFace({
    super.key,
    required this.mood,
    required this.isAnimating,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: isAnimating ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutBack,
      builder: (_, value, __) => CustomPaint(
        painter: MoodFacePainter(mood: mood, animationValue: value),
      ),
    );
  }
}
