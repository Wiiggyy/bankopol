import 'package:bankopol/models/investment.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/widgets/action_button.dart';
import 'package:bankopol/widgets/investments/investment_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BuyInvestmentBottomSheet extends ConsumerWidget {
  final Investment investment;
  final void Function() onPressedSell;

  const BuyInvestmentBottomSheet({
    required this.investment,
    required this.onPressedSell,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(
      gameStatePodProvider.select((e) => e.requireValue.player),
    );

    final canBuy = (player.bankAccount.amount) >= investment.value;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: Container(
        color: Colors.white70,
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InvestmentCard(investment: investment),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          onPressed: () {
                            ref
                                .read(gameStatePodProvider.notifier)
                                .generateCard();
                            Navigator.pop(context);
                          },
                          title: 'Köp inte',
                        ),
                      ),
                      const SizedBox(width: 1),
                      if (canBuy)
                        Expanded(
                          child: ActionButton(
                            onPressed: () {
                              ref
                                  .read(gameStatePodProvider.notifier)
                                  .buyInvestment(investment);
                              Navigator.pop(context);
                            },
                            title: 'Köp',
                          ),
                        ),
                      if (!canBuy)
                        Expanded(
                          child: ActionButton(
                            onPressed: onPressedSell,
                            title: 'Sälj investeringar',
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
