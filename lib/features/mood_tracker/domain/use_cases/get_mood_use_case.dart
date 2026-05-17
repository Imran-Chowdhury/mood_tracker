import 'package:mood_tracker/features/mood_tracker/domain/entity/mood_entity.dart';
import 'package:mood_tracker/features/mood_tracker/domain/repository/mood_repository.dart';

class GetMoodsUseCase {
  final MoodRepository _repository;

  const GetMoodsUseCase(this._repository);

  Future<List<MoodEntry>> call() => _repository.getMoodEntries();
}
