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
    return ListTile(
      leading: Text(
        getInvestmentTypeName(investment.investmentType),
        textAlign: TextAlign.left,
      ),
      title: Text(
        investment.quantity.toString(),
        textAlign: TextAlign.center,
      ),
      trailing: Text(
        (investment.value * investment.quantity).toStringAsFixed(0),
        textAlign: TextAlign.right,
      ),
    );
  }
}
