import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/widgets/action_button.dart';
import 'package:bankopol/widgets/game_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreatePlayer extends HookConsumerWidget {
  const CreatePlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
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
                            hintStyle: TextStyle(color: Colors.black26),
                          ),
                          controller: nameController,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ActionButton(
                          onPressed: () async {
                            await ref
                                .read(gameStatePodProvider.notifier)
                                .joinGame(nameController.text);
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
  }
}
