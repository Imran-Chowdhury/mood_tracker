import 'package:mood_tracker/constants/mood_constants.dart';
import 'package:mood_tracker/features/mood_tracker/data/data_source/mood_local_data_source.dart';
import 'package:mood_tracker/features/mood_tracker/data/model/mood_entry_model.dart';

class MoodLocalDatasourceImpl implements MoodLocalDatasource {
  final List<MoodEntryModel> _store = [];

  @override
  Future<List<MoodEntryModel>> getMoodEntries() async {
    await Future.delayed(Duration.zero);
    return List.unmodifiable(_store);
  }

  @override
  Future<void> addMoodEntry(MoodEntryModel entry) async {
    await Future.delayed(Duration.zero);
    _store.add(entry);

    if (_store.length > MoodConstants.maxEntries) _store.removeAt(0);
  }
}
