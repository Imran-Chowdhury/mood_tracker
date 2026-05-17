import 'package:mood_tracker/features/mood_tracker/domain/entity/mood_entity.dart';
import 'package:mood_tracker/features/mood_tracker/domain/enums/mood_type.dart';

class MoodEntryModel extends MoodEntry {
  const MoodEntryModel({
    required super.id,
    required super.mood,
    required super.date,
  });

  // ── Serialisation ──────────────────────────────────────────────────────────

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) {
    return MoodEntryModel(
      id: json['id'] as String,
      mood: MoodType.values.byName(json['mood'] as String),
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'mood': mood.name,
    'date': date.toIso8601String(),
  };

  // ── Mapping ────────────────────────────────────────────────────────────────

  factory MoodEntryModel.fromEntity(MoodEntry entry) {
    return MoodEntryModel(id: entry.id, mood: entry.mood, date: entry.date);
  }
}
