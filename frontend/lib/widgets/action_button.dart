import 'package:bankopol/constants/colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Radius? radius;

  const ActionButton({
    required this.onPressed,
    required this.title,
    this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.resolveWith((states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.all(radius ?? Radius.zero),
          );
        }),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return secondaryColor.withOpacity(0.6);
            }

            return primaryColor;
          },
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color:
              onPressed == null ? Colors.white.withOpacity(0.6) : Colors.white,
        ),
      ),
    );
  }
}
