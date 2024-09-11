import 'package:bankopol/models/game_state.dart';
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
      ..sort((a, b) => b.totalAssetsValue.compareTo(a.totalAssetsValue));
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Card(
        color: Colors.white.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Leader Board'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                for (final player in sortedPlayers)
                  Row(
                    key: ValueKey(player.id),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(player.name),
                      Text(player.totalAssetsValue.toStringAsFixed(2)),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
