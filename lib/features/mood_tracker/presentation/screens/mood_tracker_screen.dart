import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/constants/mood_sizes.dart';
import 'package:mood_tracker/features/mood_tracker/domain/enums/mood_type.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/riverpod/mood_entries_notifier.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/widgets/history_header.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/widgets/mood_history_list.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/widgets/mood_selector_card.dart';

class MoodTrackerScreen extends ConsumerStatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  ConsumerState<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends ConsumerState<MoodTrackerScreen> {
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
                    const HistoryHeader(),
                    const SizedBox(height: 16),

                    // ── History strip ────────────────────────────────────────
                    SizedBox(
                      height: isMobile
                          ? MoodSizes.mobileHistoryStripHeight
                          : MoodSizes.desktopHistoryStripHeight,
                      child: MoodHistoryList(
                        // entries: entries,
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
