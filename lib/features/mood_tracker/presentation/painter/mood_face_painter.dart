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

  void _drawNeutral(Canvas canvas, Size size, double scale) {
    final cx = size.width / 2, cy = size.height / 2;
    final r = size.width / 2 - 2 * scale;

    canvas.save();
    final tilt = (math.pi / 20) * math.sin(animationValue * math.pi);
    canvas.translate(cx, cy);
    canvas.rotate(tilt);
    canvas.translate(-cx, -cy);

    canvas.drawCircle(
      Offset(cx, cy),
      r,
      Paint()..color = MoodColors.neutralFill,
    );
    canvas.drawCircle(
      Offset(cx, cy),
      r,
      _stroke(MoodColors.neutralStroke, 2 * scale),
    );

    final brow = _stroke(MoodColors.ink, 2 * scale);
    canvas.drawLine(
      Offset(cx - size.width * .32, cy - size.height * .20),
      Offset(cx - size.width * .12, cy - size.height * .20),
      brow,
    );
    canvas.drawLine(
      Offset(cx + size.width * .12, cy - size.height * .20),
      Offset(cx + size.width * .32, cy - size.height * .20),
      brow,
    );

    final dot = Paint()..color = MoodColors.ink;
    canvas.drawCircle(
      Offset(cx - size.width * .22, cy - size.height * .04),
      4 * scale,
      dot,
    );
    canvas.drawCircle(
      Offset(cx + size.width * .22, cy - size.height * .04),
      4 * scale,
      dot,
    );

    final mouthHalfW =
        (size.width * 0.26 - animationValue * size.width * 0.06) / 2;
    canvas.drawLine(
      Offset(cx - mouthHalfW, cy + size.height * .18),
      Offset(cx + mouthHalfW, cy + size.height * .18),
      _stroke(MoodColors.ink, 3 * scale),
    );

    canvas.restore();
  }

  // ── Sad ───────────────────────────────────────────────────────────────────

  void _drawSad(Canvas canvas, Size size, double scale) {
    final cx = size.width / 2, cy = size.height / 2;
    final r = size.width / 2 - 2 * scale;

    canvas.drawCircle(Offset(cx, cy), r, Paint()..color = MoodColors.sadFill);
    canvas.drawCircle(
      Offset(cx, cy),
      r,
      _stroke(MoodColors.sadStroke, 2 * scale),
    );

    final brow = _stroke(MoodColors.ink, 2.5 * scale);
    canvas.drawLine(
      Offset(cx - size.width * .32, cy - size.height * .24),
      Offset(cx - size.width * .12, cy - size.height * .30),
      brow,
    );
    canvas.drawLine(
      Offset(cx + size.width * .12, cy - size.height * .30),
      Offset(cx + size.width * .32, cy - size.height * .24),
      brow,
    );

    final eyePaint = _stroke(MoodColors.ink, 2.5 * scale);
    final leftEye = Offset(cx - size.width * .22, cy - size.height * .06);
    final rightEye = Offset(cx + size.width * .22, cy - size.height * .06);
    canvas.drawArc(
      Rect.fromCenter(
        center: leftEye,
        width: size.width * 0.16,
        height: size.height * 0.12,
      ),
      math.pi,
      math.pi,
      false,
      eyePaint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: rightEye,
        width: size.width * 0.16,
        height: size.height * 0.12,
      ),
      math.pi,
      math.pi,
      false,
      eyePaint,
    );

    if (animationValue > 0.05) {
      final tearPaint = Paint()
        ..color = MoodColors.tear
        ..style = PaintingStyle.fill;
      final tearR = animationValue * 3.5 * scale;
      final drop = animationValue * size.height * 0.12;
      canvas.drawCircle(
        leftEye + Offset(0, 2 * scale + drop),
        tearR,
        tearPaint,
      );
      canvas.drawCircle(
        rightEye + Offset(0, 2 * scale + drop),
        tearR,
        tearPaint,
      );
    }

    final tremble = animationValue > 0
        ? 1.2 * scale * math.sin(animationValue * math.pi * 5)
        : 0.0;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(cx, cy + size.height * .20 + tremble),
        width: size.width * 0.28,
        height: size.height * 0.16 + animationValue * size.height * 0.08,
      ),
      math.pi,
      math.pi,
      false,
      _stroke(MoodColors.ink, 3 * scale),
    );
  }

  // ── Angry ─────────────────────────────────────────────────────────────────

  void _drawAngry(Canvas canvas, Size size, double scale) {
    final cx = size.width / 2, cy = size.height / 2;
    final r = size.width / 2 - 2 * scale;

    canvas.drawCircle(Offset(cx, cy), r, Paint()..color = MoodColors.angryFill);
    canvas.drawCircle(
      Offset(cx, cy),
      r,
      _stroke(MoodColors.angryStroke, 2 * scale),
    );

    final squint = animationValue * 3.5 * scale;
    final eyeFill = Paint()..color = MoodColors.ink;

    canvas.drawPath(
      Path()
        ..moveTo(cx - size.width * .34, cy - size.height * .05)
        ..lineTo(cx - size.width * .12, cy - size.height * .10 + squint)
        ..lineTo(cx - size.width * .12, cy - size.height * .02)
        ..lineTo(cx - size.width * .34, cy - squint)
        ..close(),
      eyeFill,
    );

    canvas.drawPath(
      Path()
        ..moveTo(cx + size.width * .12, cy - size.height * .10 + squint)
        ..lineTo(cx + size.width * .34, cy - size.height * .05)
        ..lineTo(cx + size.width * .34, cy - squint)
        ..lineTo(cx + size.width * .12, cy - size.height * .02)
        ..close(),
      eyeFill,
    );

    final browDrop = animationValue * 4.0 * scale;
    final browPaint = _stroke(MoodColors.ink, 4.5 * scale);
    canvas.drawLine(
      Offset(cx - size.width * .36, cy - size.height * .24 + browDrop),
      Offset(cx - size.width * .10, cy - size.height * .15 + browDrop * 1.5),
      browPaint,
    );
    canvas.drawLine(
      Offset(cx + size.width * .36, cy - size.height * .24 + browDrop),
      Offset(cx + size.width * .10, cy - size.height * .15 + browDrop * 1.5),
      browPaint,
    );

    final mouthRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy + size.height * .22),
        width: size.width * 0.45,
        height: size.height * 0.15,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(mouthRect, Paint()..color = Colors.white);
    canvas.drawRRect(mouthRect, _stroke(MoodColors.ink, 2 * scale));
  }

  @override
  bool shouldRepaint(covariant MoodFacePainter old) =>
      old.mood != mood || old.animationValue != animationValue;
}
