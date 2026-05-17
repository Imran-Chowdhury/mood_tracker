import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/constants/mood_constants.dart';
import 'package:mood_tracker/features/mood_tracker/domain/entity/mood_entity.dart';
import 'package:mood_tracker/features/mood_tracker/domain/enums/mood_type.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/riverpod/mood_providers.dart';

class MoodNotifier extends AsyncNotifier<List<MoodEntry>> {
  @override
  Future<List<MoodEntry>> build() {
    return ref.read(getMoodEntriesUseCaseProvider).call();
  }

  Future<void> addEntry(MoodType mood) async {
    final entry = MoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      mood: mood,
      date: DateTime.now(),
    );

    // ── Optimistic update ─────────────────────────────────────────────────
    // Apply the rolling-window rule locally so the displayed list matches
    // what will be stored, without waiting for the async persist.
    final current = state.value ?? [];
    var optimistic = [...current, entry];
    if (optimistic.length > MoodConstants.maxEntries) {
      optimistic = optimistic.sublist(1);
    }
    state = AsyncData(optimistic);

    // ── Persist ───────────────────────────────────────────────────────────
    // Fire-and-forget; the datasource enforces the cap independently.
    await ref.read(addMoodEntryUseCaseProvider).call(entry);
  }
}

final moodNotifierProvider =
    AsyncNotifierProvider<MoodNotifier, List<MoodEntry>>(MoodNotifier.new);
