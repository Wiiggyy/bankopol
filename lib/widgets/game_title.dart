import 'package:bankopol/constants/colors.dart';
import 'package:flutter/material.dart';

class GameTitle extends StatelessWidget {
  const GameTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Skandopoly',
        style: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: primaryGreen,
          shadows: [
            Shadow(offset: Offset(2, 2)),
          ],
        ),
      ),
    );
  }
}
