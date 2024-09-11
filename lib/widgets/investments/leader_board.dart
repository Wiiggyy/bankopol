import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/models/player.dart';
import 'package:bankopol/widgets/investments/investment_item.dart';
import 'package:bankopol/widgets/investments/investment_item_header.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {
  final GameState gameState;

  const LeaderBoard({
    required this.gameState,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sortedPlayers = gameState.players.toList()
      ..sort(
          (a, b) => b.totalInvestmentValue.compareTo(a.totalInvestmentValue));
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ColoredBox(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.grey,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: const Text(
                  'Leader Board',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              for (final player in sortedPlayers)
                Row(
                  key: ValueKey(player.id),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(player.name),
                    Text(player.totalInvestmentValue.toString()),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
