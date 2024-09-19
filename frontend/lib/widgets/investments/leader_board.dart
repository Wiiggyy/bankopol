import 'package:bankopol/extensions/map_extension.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LeaderBoard extends ConsumerWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortedPlayers = ref.watch(
      gameStatePodProvider.select(
        (gameState) => gameState.requireValue.highScore.records.toList()
          ..sort((a, b) => b.$2.compareTo(a.$2)),
      ),
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 300,
        minHeight: 100,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.2,
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sortedPlayers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final (name, totalAssetsValue) = sortedPlayers[index];

                    return ListTile(
                      leading: SizedBox(
                        width: 30,
                        child: index == 0 ? const Icon(Icons.star) : null,
                      ),
                      title: Text(
                        name,
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: Text(
                        totalAssetsValue.toStringAsFixed(2),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
