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
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 300,
        minHeight: 100,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.2,
        maxChildSize: 1,
        builder: (context, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Text(
                    'Leaderboard'.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Divider(
                height: 0,
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (int index = 0;
                        index < sortedPlayers.length;
                        index++) ...[
                      ListTile(
                        leading: SizedBox(
                          width: 30,
                          child: index == 0 ? const Icon(Icons.star) : null,
                        ),
                        title: Text(
                          sortedPlayers[index].name,
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: Text(
                          sortedPlayers[index]
                              .totalAssetsValue
                              .toStringAsFixed(2),
                        ),
                      ),
                      const Divider(
                        height: 0,
                      )
                    ]
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
