import 'package:flutter/material.dart';

abstract final class MoodColors {
  // ── Mood label / border tints ──────────────────────────────────────────────
  static const Color happy = Color(0xFF4CAF50);
  static const Color neutral = Color(0xFFFFB300);
  static const Color sad = Color(0xFF5C6BC0);
  static const Color angry = Color(0xFFB5513A);

  // ── Face fill colours ──────────────────────────────────────────────────────
  static const Color happyFill = Color(0xFFFFD740);
  static const Color happyStroke = Color(0xFFBB8800);
  static const Color neutralFill = Color(0xFF5DBD8A);
  static const Color neutralStroke = Color(0xFF2E8055);
  static const Color sadFill = Color(0xFF5C6BC0);
  static const Color sadStroke = Color(0xFF3F51B5);
  static const Color angryFill = Color(0xFFB5513A);
  static const Color angryStroke = Color(0xFF7A2818);

  // ── Miscellaneous ──────────────────────────────────────────────────────────
  static const Color tear = Color(0xFFE0F7FA);
  static const Color ink = Color(0xFF1A1A1A);
  static const Color scaffoldBackground = Color(0xFFF4F7FB);
  static const Color cardBackground = Colors.white;
  static const Color emptyHint = Colors.black38;
  static const Color subtitleText = Colors.black54;
}
