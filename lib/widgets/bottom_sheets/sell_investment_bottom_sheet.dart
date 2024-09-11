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
            return Container(
              constraints: BoxConstraints(
                minHeight: 500, // Set minimum height to 500
                maxWidth: double.infinity,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Swipa för att sälja investering',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    for (final investment
                        in gameProvider.currentPlayer?.investments ??
                            <Investment>{})
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Dismissible(
                          key: ObjectKey(investment),
                          onDismissed: (direction) {
                            gameProvider.sellInvestment(investment);
                            Navigator.of(context).pop();
                          },
                          background: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.shade500,
                              borderRadius: BorderRadius.circular(
                                  16.0), // Border radius for the background
                            ),
                            child: const Icon(Icons.delete),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: InvestmentCard(
                                key: ObjectKey(investment),
                                investment: investment),
                          ),
                        ),
                      ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
