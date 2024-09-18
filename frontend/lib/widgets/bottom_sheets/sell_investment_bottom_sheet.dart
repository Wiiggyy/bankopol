import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/widgets/investments/investment_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SellInvestmentBottomSheet extends ConsumerWidget {
  const SellInvestmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(
      gameStatePodProvider.select((e) => e.requireValue.player),
    );

    return SizedBox(
      height: 500,
      child: DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.2,
        builder: (context, _) {
          return Column(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Text(
                    'Swipa för att sälja investering',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (final investment in player.investments)
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: Dismissible(
                          key: ObjectKey(investment),
                          onDismissed: (direction) {
                            ref
                                .read(gameStatePodProvider.notifier)
                                .sellInvestment(investment);
                            Navigator.of(context).pop();
                          },
                          background: Container(
                            margin: const EdgeInsets.all(8),
                            child: const Icon(Icons.delete),
                          ),
                          child: InvestmentCard(
                            key: ObjectKey(investment),
                            investment: investment,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
