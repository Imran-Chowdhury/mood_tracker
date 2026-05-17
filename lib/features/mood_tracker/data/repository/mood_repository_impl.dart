import 'package:mood_tracker/features/mood_tracker/data/data_source/mood_local_data_source.dart';
import 'package:mood_tracker/features/mood_tracker/data/model/mood_entry_model.dart';
import 'package:mood_tracker/features/mood_tracker/domain/entity/mood_entity.dart';
import 'package:mood_tracker/features/mood_tracker/domain/repository/mood_repository.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodLocalDatasource _datasource;

  const MoodRepositoryImpl(this._datasource);

  @override
  Future<List<MoodEntry>> getMoodEntries() => _datasource.getMoodEntries();

  @override
  Future<void> addMoodEntry(MoodEntry entry) =>
      _datasource.addMoodEntry(MoodEntryModel.fromEntity(entry));
}
