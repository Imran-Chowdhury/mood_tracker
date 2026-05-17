import 'package:mood_tracker/features/mood_tracker/domain/entity/mood_entity.dart';

abstract interface class MoodRepository {
  Future<List<MoodEntry>> getMoodEntries();
  Future<void> addMoodEntry(MoodEntry entry);
}
