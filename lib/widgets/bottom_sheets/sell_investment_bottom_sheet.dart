import 'package:bankopol/models/investment.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/widgets/investments/investment_card.dart';
import 'package:flutter/material.dart';

class SellInvestmentBottomSheet extends StatelessWidget {
  final GameProvider gameProvider;

  const SellInvestmentBottomSheet({
    required this.gameProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ListenableBuilder(
          listenable: gameProvider,
          builder: (context, __) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (final investment
                      in gameProvider.currentPlayer?.investments ??
                          <Investment>{})
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Dismissible(
                        key: ObjectKey(investment),
                        onDismissed: (direction) {
                          gameProvider.sellInvestment(investment);
                          Navigator.of(context).pop();
                        },
                        background: Container(
                          color: Colors.red.shade500,
                          child: const Icon(Icons.delete),
                        ),
                        child: InvestmentCard(
                            key: ObjectKey(investment), investment: investment),
                      ),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
