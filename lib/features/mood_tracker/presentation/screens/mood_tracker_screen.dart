import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/riverpod/mood_entries_notifier.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/widgets/mood_history_list.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/widgets/mood_selector_card.dart';

import '../../domain/enums/mood_type.dart';
import '../../../../constants/mood_sizes.dart';

/// Root screen for the mood tracker feature.
///
/// State responsibilities:
/// - [_animatedIndexNotifier] — local UI state (which entry card is animating).
///   Lives here as a [ValueNotifier] so that mutations only rebuild the
///   individual [MoodEntryCard] that subscribed, not this whole screen.
/// - Entry list — owned by [MoodEntriesNotifier] via Riverpod.
///   [ref.watch] here triggers a screen rebuild only when the entry list
///   itself changes (add / remove), not on animation events.
class MoodTrackerScreen extends ConsumerStatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  ConsumerState<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends ConsumerState<MoodTrackerScreen> {
  /// Tracks which history-card index is currently animating.
  /// [ValueNotifier] instead of setState: mutating this does NOT rebuild the
  /// screen — only the [ValueListenableBuilder] inside the targeted card.
  final ValueNotifier<int?> _animatedIndexNotifier = ValueNotifier<int?>(null);

  @override
  void dispose() {
    _animatedIndexNotifier.dispose();
    super.dispose();
  }

  void _onCardTap(int index) {
    _animatedIndexNotifier.value = index;
    Future.delayed(const Duration(milliseconds: 500), () {
      // Guard: notifier may have been disposed if the user navigated away.
      if (_animatedIndexNotifier.value == index) {
        _animatedIndexNotifier.value = null;
      }
    });
  }

  void _onMoodSelected(MoodType mood) {
    ref.read(moodNotifierProvider.notifier).addEntry(mood);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < MoodSizes.mobileBreakpoint;
    final hPad = isMobile
        ? MoodSizes.pagePaddingMobile
        : MoodSizes.pagePaddingDesktop;

    // Watch the entries list. Rebuilds this screen only when entries change.
    final entriesAsync = ref.watch(moodNotifierProvider);
    final entries = entriesAsync.value ?? [];

    return Scaffold(
      body: SafeArea(
        // SingleChildScrollView prevents overflow on very small / landscape screens.
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: MoodSizes.maxContentWidth,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: hPad,
                  vertical: MoodSizes.pageVerticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header ───────────────────────────────────────────────
                    Text(
                      'Mood Tracker',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: MoodSizes.headerSubtitleGap),
                    Text(
                      'Tap a mood to log how you feel today.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: MoodSizes.sectionGap),

                    // ── Mood Selector ────────────────────────────────────────
                    isMobile
                        ? SizedBox(
                            height: MoodSizes.selectorScrollHeight,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: MoodType.values
                                  .map(
                                    (mood) => MoodSelectorCard(
                                      mood: mood,
                                      isHorizontalScroll: true,
                                      onTap: () => _onMoodSelected(mood),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount:
                                size.width < MoodSizes.tabletBreakpoint
                                ? MoodSizes.gridColumnsMobile
                                : MoodSizes.gridColumnsDesktop,
                            crossAxisSpacing: MoodSizes.gridSpacing,
                            mainAxisSpacing: MoodSizes.gridSpacing,
                            childAspectRatio: MoodSizes.gridAspectRatio,
                            children: MoodType.values
                                .map(
                                  (mood) => MoodSelectorCard(
                                    mood: mood,
                                    isHorizontalScroll: false,
                                    onTap: () => _onMoodSelected(mood),
                                  ),
                                )
                                .toList(),
                          ),

                    const SizedBox(height: MoodSizes.sectionGap),

                    // ── History header ───────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Past 7 Entries',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${entries.length}/7 logged',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ── History strip ────────────────────────────────────────
                    SizedBox(
                      height: MoodSizes.historyStripHeight,
                      child: MoodHistoryList(
                        entries: entries,
                        isMobile: isMobile,
                        animatedIndexNotifier: _animatedIndexNotifier,
                        onCardTap: _onCardTap,
                      ),
                    ),

                    const SizedBox(height: MoodSizes.bottomPadding),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
