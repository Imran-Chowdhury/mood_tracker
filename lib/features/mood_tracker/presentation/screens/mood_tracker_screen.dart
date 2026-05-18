import 'package:flutter/material.dart';
import 'package:mood_tracker/constants/mood_sizes.dart';
import 'package:mood_tracker/features/mood_tracker/domain/enums/mood_type.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/widgets/history_header.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/widgets/mood_history_list.dart';
import 'package:mood_tracker/features/mood_tracker/presentation/widgets/mood_selector_card.dart';

class MoodTrackerScreen extends StatelessWidget {
  const MoodTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < MoodSizes.mobileBreakpoint;
    final hPad = isMobile
        ? MoodSizes.pagePaddingMobile
        : MoodSizes.pagePaddingDesktop;

    return Scaffold(
      body: SafeArea(
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
                                      // onTap: () => _onMoodSelected(mood),
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
                                    // onTap: () => _onMoodSelected(mood),
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
                        // animatedIndexNotifier: _animatedIndexNotifier,
                        // onCardTap: _onCardTap,
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
