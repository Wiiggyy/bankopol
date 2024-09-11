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
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            return primaryGreen;
          },
        ),
      ),
    );
  }
}
