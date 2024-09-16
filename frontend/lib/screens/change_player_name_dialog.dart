import 'package:bankopol/models/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChangePlayerNameDialog extends HookWidget {
  final Player player;

  const ChangePlayerNameDialog({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final nameController = useTextEditingController(
          text: player.name,
        );

        void finish() {
          if (nameController.text.isNotEmpty) {
            Navigator.of(context).pop(nameController.text);
          }
        }

        return AlertDialog(
          content: TextField(
            controller: nameController,
            onSubmitted: (_) => finish(),
          ),
          actions: [
            TextButton(
              onPressed: finish,
              child: const Text('Spara'),
            ),
            TextButton(
              onPressed: finish,
              child: const Text('Avbryt'),
            ),
          ],
          // content:,
        );
      },
    );
  }
}
