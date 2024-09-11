import 'package:bankopol/enums/investment_type.dart';
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
      padding: const EdgeInsets.symmetric(
        // horizontal: 16,
        vertical: 4,
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.black,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(
                getInvestmentTypeName(investment.investmentType),
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
              flex: 1,
              child: Text(
                (investment.value * investment.quantity).toStringAsFixed(0),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
