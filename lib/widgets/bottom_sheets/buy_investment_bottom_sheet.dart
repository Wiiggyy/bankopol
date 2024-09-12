import 'package:bankopol/models/investment.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/widgets/action_button.dart';
import 'package:bankopol/widgets/investments/investment_card.dart';
import 'package:flutter/material.dart';

class BuyInvestmentBottomSheet extends StatefulWidget {
  final GameProvider gameProvider;
  final void Function() onPressed;
  final void Function() onPressedSell;
  final void Function() onPressedClose;

  const BuyInvestmentBottomSheet({
    required this.gameProvider,
    required this.onPressed,
    required this.onPressedSell,
    required this.onPressedClose,
    super.key,
  });

  @override
  State<BuyInvestmentBottomSheet> createState() =>
      _BuyInvestmentBottomSheetState();
}

class _BuyInvestmentBottomSheetState extends State<BuyInvestmentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final Investment investment = Investment.generateRandomInvestment();

    return ListenableBuilder(
      listenable: widget.gameProvider,
      builder: (context, __) {
        final bool canBuy =
            (widget.gameProvider.currentPlayer?.bankAccount.amount ?? 0) >=
                investment.value;
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: Container(
            color: Colors.white60,
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
                              onPressed: widget.onPressedClose,
                              title: 'Köp inte',
                            ),
                          ),
                          const SizedBox(width: 1),
                          if (canBuy)
                            Expanded(
                              child: ActionButton(
                                onPressed: () {
                                  widget.gameProvider.buyInvestment(investment);
                                  widget.onPressed();
                                },
                                title: 'Köp',
                              ),
                            ),
                          if (!canBuy)
                            Expanded(
                              child: ActionButton(
                                onPressed: widget.onPressedSell,
                                title: 'Sälj investeringar',
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
