import 'package:bankopol/models/investment.dart';
import 'package:bankopol/models/player.dart';
import 'package:bankopol/widgets/investments/investment_item.dart';
import 'package:bankopol/widgets/investments/investment_item_header.dart';
import 'package:flutter/material.dart';

class InvestmentList extends StatelessWidget {
  final Player player;

  const InvestmentList({
    required this.player,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Card(
        color: Colors.white.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const InvestmentItemHeader(),
                InvestmentItem(
                    investment: Investment.generateRandomInvestment()),
                for (final investment in player.investments)
                  InvestmentItem(investment: investment),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
