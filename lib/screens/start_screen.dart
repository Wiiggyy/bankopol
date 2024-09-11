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
  final TextEditingController nameController = TextEditingController();

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const GameTitle(),
                    TextField(
                      controller: nameController,
                    ),
                    ActionButton(
                      onPressed: () async {
                        await widget.gameProvider.joinGame(nameController.text);

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
