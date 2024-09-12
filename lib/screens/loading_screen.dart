import 'package:bankopol/widgets/game_title.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.jpeg',
            fit: BoxFit.cover,
          ),
          const SafeArea(child: GameTitle()),
        ],
      ),
    );
  }
}
