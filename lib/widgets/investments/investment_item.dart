import 'package:bankopol/constants/text_style.dart';
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
    return Stack(
      children: [
        SizedBox(
          height: 55,
          width: double.infinity,
          child: Image.asset(
            'assets/${investment.investmentType.name}.webp',
            fit: BoxFit.fitWidth,
          ),
        ),
        ListTile(
          leading: Text(
            getInvestmentTypeName(investment.investmentType),
            textAlign: TextAlign.left,
            style: investmentListTextStyle,
          ),
          trailing: Text(
            '${(investment.value * investment.quantity).toStringAsFixed(0)} (${investment.quantity.toString()})',
            textAlign: TextAlign.right,
            style: investmentListTextStyle,
          ),
        ),
      ],
    );
  }
}
