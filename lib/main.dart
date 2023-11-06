import 'package:flutter/material.dart';
import 'package:news_checker/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News Fact Checker',
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.blueAccent.shade100),
            useMaterial3: true,
            fontFamily: 'Inter',
            filledButtonTheme: FilledButtonThemeData(
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(12))))),
        home: const SplashScreen());
  }
}
