import '../enums/mood_type.dart';

class MoodEntry {
  final String id;
  final MoodType mood;
  final DateTime date;

  const MoodEntry({required this.id, required this.mood, required this.date});
}
