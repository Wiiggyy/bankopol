import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/screens/create_player_screen.dart';
import 'package:bankopol/screens/loading_screen.dart';
import 'package:bankopol/screens/player_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  final GameProvider gameProvider;

  const StartScreen({
    required this.gameProvider,
    super.key,
  });

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    widget.gameProvider.tryRejoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.gameProvider,
      builder: (context, __) {
        return switch (widget.gameProvider.isLoggedIn) {
          null => const LoadingScreen(),
          true => PlayerScreen(gameProvider: widget.gameProvider),
          false => CreatePlayer(gameProvider: widget.gameProvider),
        };
      },
    );
  }
}
