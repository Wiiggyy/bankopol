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
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: Image.asset(
                'assets/${investment.investmentType.name}.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            getInvestmentTypeName(investment.investmentType),
            textAlign: TextAlign.left,
          ),
        ],
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
