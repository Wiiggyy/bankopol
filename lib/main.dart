import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      theme: ThemeData(
          // textTheme: GoogleFonts.rubikTextTheme(
          //   Theme.of(context).textTheme,
          // ),
          ),
      title: 'Flutter Demo',
      home: StartScreen(
        gameProvider: gameProvider,
      ),
      // home: PlayerScreen(),
    );
  }
}
