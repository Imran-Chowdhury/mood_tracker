import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mood_tracker/features/mood_tracker/domain/entity/mood_entity.dart';
import 'package:mood_tracker/constants/mood_colors.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/widgets/mood_history_item.dart';

class MoodHistoryList extends StatelessWidget {
  final List<MoodEntry> entries;
  final bool isMobile;
  final ValueNotifier<int?> animatedIndexNotifier;
  final void Function(int index) onCardTap;

  const MoodHistoryList({
    super.key,
    required this.entries,
    required this.isMobile,
    required this.animatedIndexNotifier,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Center(
        child: Text(
          'No entries logged yet!',
          style: TextStyle(color: MoodColors.emptyHint, fontSize: 16),
        ),
      );
    }

    return ScrollConfiguration(
      behavior: _WebScrollBehavior(),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: entries.length,
        itemBuilder: (_, index) => MoodHistoryItem(
          index: index,
          entry: entries[index],
          isMobile: isMobile,
          animatedIndexNotifier: animatedIndexNotifier,
          onTap: () => onCardTap(index),
        ),
      ),
    );
  }
}

class _WebScrollBehavior extends MaterialScrollBehavior {
  const _WebScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.trackpad,
  };
}
