import 'package:bankopol/constants/colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;

  const ActionButton({
    required this.onPressed,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.resolveWith((states) {
          return const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero),
          );
        }),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            return primaryGreen;
          },
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
