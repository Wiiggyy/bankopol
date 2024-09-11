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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            const InvestmentItemHeader(),
            for (final investment in player.investments)
              InvestmentItem(investment: investment),
          ],
        ),
      ),
    );
  }
}
