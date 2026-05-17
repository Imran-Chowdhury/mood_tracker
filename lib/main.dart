import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/mood_tracker/domain/constants/mood_colors.dart';

void main() {
  runApp(const ProviderScope(child: MoodTrackerApp()));
}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mood Tracker',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: MoodColors.scaffoldBackground,
      ),
      home: const Scaffold(body: Column(children: [
            
          ],
        )),
    );
  }
}
