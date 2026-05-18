import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/riverpod/mood_entries_notifier.dart';

class HistoryHeader extends ConsumerWidget {
  const HistoryHeader({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // Watch the entries list. Rebuilds this screen only when entries change.
    final entriesAsync = ref.watch(moodNotifierProvider);
    final entries = entriesAsync.value ?? [];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Past 7 Entries',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '${entries.length}/7 logged',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
