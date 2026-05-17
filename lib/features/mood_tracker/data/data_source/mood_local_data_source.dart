import 'package:mood_tracker/features/mood_tracker/data/model/mood_entry_model.dart';

abstract interface class MoodLocalDatasource {
  Future<List<MoodEntryModel>> getMoodEntries();
  Future<void> addMoodEntry(MoodEntryModel entry);
}
