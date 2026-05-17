import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker/features/mood_tracker/domain/entity/mood_entity.dart';
import 'package:mood_tracker/constants/mood_colors.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/widgets/mood_history_item.dart';

class MoodHistoryList extends StatefulWidget {
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
  State<MoodHistoryList> createState() => _MoodHistoryListState();
}

class _MoodHistoryListState extends State<MoodHistoryList> {
  late final ScrollController _controller;

  // How many logical pixels one wheel tick scrolls. Tune to taste.
  static const double _scrollSpeed = 80.0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      final delta = event.scrollDelta.dy + event.scrollDelta.dx;
      final target = (_controller.offset + delta * _scrollSpeed / 100).clamp(
        0.0,
        _controller.position.maxScrollExtent,
      );
      _controller.jumpTo(target);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.entries.isEmpty) {
      return const Center(
        child: Text(
          'No entries logged yet!',
          style: TextStyle(color: MoodColors.emptyHint, fontSize: 16),
        ),
      );
    }

    return Listener(
      onPointerSignal: _onPointerSignal,
      child: ScrollConfiguration(
        behavior: const _WebScrollBehavior(),
        child: ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          itemCount: widget.entries.length,
          itemBuilder: (_, index) => MoodHistoryItem(
            index: index,
            entry: widget.entries[index],
            isMobile: widget.isMobile,
            animatedIndexNotifier: widget.animatedIndexNotifier,
            onTap: () => widget.onCardTap(index),
          ),
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
  };
}
