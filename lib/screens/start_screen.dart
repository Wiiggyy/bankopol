import 'package:bankopol/screens/player_screen.dart';
import 'package:bankopol/screens/scanner_screen.dart';
import 'package:bankopol/widgets/action_button.dart';
import 'package:bankopol/widgets/game_title.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

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
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const GameTitle(),
                ActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PlayerScreen(),
                      ),
                    );
                  },
                  title: 'Börja spela',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
