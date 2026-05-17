import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/enums/mood_type.dart';
import '../constants/mood_colors.dart';

class MoodFacePainter extends CustomPainter {
  final MoodType mood;
  final double animationValue;

  const MoodFacePainter({required this.mood, required this.animationValue});

  Paint _stroke(Color c, double w) => Paint()
    ..color = c
    ..style = PaintingStyle.stroke
    ..strokeWidth = w
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    // Scale stroke weights relative to the canvas so faces look consistent
    final scale = size.width / 100.0;

    switch (mood) {
      case MoodType.happy:
        _drawHappy(canvas, size, scale);
      case MoodType.neutral:
        _drawNeutral(canvas, size, scale);
      case MoodType.sad:
        _drawSad(canvas, size, scale);
      case MoodType.angry:
        _drawAngry(canvas, size, scale);
    }
  }

  // ── Happy ──────────────────────────────────────────────────────────────────

  void _drawHappy(Canvas canvas, Size size, double scale) {
    final cx = size.width / 2, cy = size.height / 2;
    final r = size.width / 2 - 2 * scale;

    canvas.drawCircle(Offset(cx, cy), r, Paint()..color = MoodColors.happyFill);
    canvas.drawCircle(
      Offset(cx, cy),
      r,
      _stroke(MoodColors.happyStroke, 2 * scale),
    );

    final brow = _stroke(MoodColors.ink, 2.5 * scale);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(cx - size.width * .22, cy - size.height * .28),
        width: size.width * 0.22,
        height: size.height * 0.11,
      ),
      math.pi + .35,
      math.pi - .70,
      false,
      brow,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(cx + size.width * .22, cy - size.height * .28),
        width: size.width * 0.22,
        height: size.height * 0.11,
      ),
      math.pi + .35,
      math.pi - .70,
      false,
      brow,
    );

    final dot = Paint()..color = MoodColors.ink;
    canvas.drawCircle(
      Offset(cx - size.width * .22, cy - size.height * .10),
      4 * scale,
      dot,
    );
    canvas.drawCircle(
      Offset(cx + size.width * .22, cy - size.height * .10),
      4 * scale,
      dot,
    );

    final mouthW = size.width * 0.45 + animationValue * size.width * 0.10;
    final mouthH = size.height * 0.30 + animationValue * size.height * 0.12;
    final mouthY = cy + size.height * .12 - animationValue * 3 * scale;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(cx, mouthY),
        width: mouthW,
        height: mouthH,
      ),
      .12,
      math.pi - .24,
      false,
      _stroke(MoodColors.ink, 3 * scale),
    );
  }

  // ── Neutral ────────────────────────────────────────────────────────────────

  void _drawNeutral(Canvas canvas, Size size, double scale) {}

  // ── Sad ───────────────────────────────────────────────────────────────────

  void _drawSad(Canvas canvas, Size size, double scale) {}

  // ── Angry ─────────────────────────────────────────────────────────────────

  void _drawAngry(Canvas canvas, Size size, double scale) {}

  @override
  bool shouldRepaint(covariant MoodFacePainter old) =>
      old.mood != mood || old.animationValue != animationValue;
}
