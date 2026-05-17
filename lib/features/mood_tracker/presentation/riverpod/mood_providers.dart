import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/mood_tracker/data/data_source/mood_local_data_source.dart';
import 'package:mood_tracker/features/mood_tracker/data/data_source/mood_local_data_source_impl.dart';
import 'package:mood_tracker/features/mood_tracker/data/repository/mood_repository_impl.dart';
import 'package:mood_tracker/features/mood_tracker/domain/repository/mood_repository.dart';
import 'package:mood_tracker/features/mood_tracker/domain/use_cases/add_mood_use_case.dart';
import 'package:mood_tracker/features/mood_tracker/domain/use_cases/get_mood_use_case.dart';

/// Data source providers
final moodLocalDatasourceProvider = Provider<MoodLocalDatasource>(
  (_) => MoodLocalDatasourceImpl(),
);

/// Repository providers.
final moodRepositoryProvider = Provider<MoodRepository>(
  (ref) => MoodRepositoryImpl(ref.read(moodLocalDatasourceProvider)),
);

/// Use case providers
final addMoodEntryUseCaseProvider = Provider<AddMoodUseCase>(
  (ref) => AddMoodUseCase(ref.read(moodRepositoryProvider)),
);

final getMoodEntriesUseCaseProvider = Provider<GetMoodsUseCase>(
  (ref) => GetMoodsUseCase(ref.read(moodRepositoryProvider)),
);
