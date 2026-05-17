import 'package:mood_tracker/features/mood_tracker/domain/entity/mood_entity.dart';
import 'package:mood_tracker/features/mood_tracker/domain/repository/mood_repository.dart';

class AddMoodUseCase {
  final MoodRepository _repository;

  const AddMoodUseCase(this._repository);

  Future<void> call(MoodEntry entry) => _repository.addMoodEntry(entry);
}
