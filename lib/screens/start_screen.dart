import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/screens/player_screen.dart';
import 'package:bankopol/widgets/action_button.dart';
import 'package:bankopol/widgets/game_title.dart';
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
  String name = '';

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.gameProvider,
      builder: (context, __) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/background.jpeg',
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: Stack(
                  children: [
                    const GameTitle(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(8),
                            child: TextField(
                              decoration: const InputDecoration(
                                  hintText: 'Spelarnamn',
                                  hintStyle: TextStyle(color: Colors.black26)),
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ActionButton(
                              onPressed: () async {
                                await widget.gameProvider.joinGame(name);

                                if (!context.mounted) return;

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PlayerScreen(
                                      gameProvider: widget.gameProvider,
                                    ),
                                  ),
                                );
                              },
                              title: 'Börja spela',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
