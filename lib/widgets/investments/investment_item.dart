import 'package:bankopol/models/investment.dart';
import 'package:flutter/material.dart';

class InvestmentItem extends StatelessWidget {
  final Investment investment;

  const InvestmentItem({
    required this.investment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              investment.investmentType.name,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              investment.quantity.toString(),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              (investment.value * investment.quantity).toString(),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
