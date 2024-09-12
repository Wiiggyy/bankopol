import 'package:bankopol/constants/text_style.dart';
import 'package:flutter/material.dart';

class InvestmentItemHeader extends StatelessWidget {
  const InvestmentItemHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      dense: true,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Investering',
            textAlign: TextAlign.left,
            style: investmentListTextStyle,
          ),
        ],
      ),
      trailing: Text(
        'Värde',
        textAlign: TextAlign.right,
        style: investmentListTextStyle,
      ),
    );
  }
}
