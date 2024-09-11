import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/screens/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GameProvider gameProvider = GameProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: StartScreen(
        gameProvider: gameProvider,
      ),
      // home: PlayerScreen(),
    );
  }
}
