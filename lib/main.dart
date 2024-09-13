import 'package:bankopol/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // textTheme: GoogleFonts.rubikTextTheme(
          //   Theme.of(context).textTheme,
          // ),
          ),
      title: 'Flutter Demo',
      home: const StartScreen(),
      // home: PlayerScreen(),
    );
  }
}
