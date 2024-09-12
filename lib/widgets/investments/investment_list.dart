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
      color: Colors.white.withOpacity(0.2),
      // margin: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const InvestmentItemHeader(),
            for (final investment in player.investments) ...[
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              InvestmentItem(investment: investment),
            ],
          ],
        ),
      ),
    );
  }
}
