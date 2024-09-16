import 'package:bankopol/models/investment.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/widgets/action_button.dart';
import 'package:bankopol/widgets/investments/investment_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BuyInvestmentBottomSheet extends ConsumerWidget {
  final Investment investment;
  final void Function() onPressed;
  final void Function() onPressedSell;
  final void Function() onPressedClose;

  const BuyInvestmentBottomSheet({
    required this.investment,
    required this.onPressed,
    required this.onPressedSell,
    required this.onPressedClose,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPlayer = ref.watch(currentPlayerProvider).requireValue!;

    final canBuy = (currentPlayer.bankAccount.amount) >= investment.value;
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
                          onPressed: onPressedClose,
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
                              onPressed();
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
