import 'package:bankopol/constants/text_style.dart';
import 'package:flutter/material.dart';

class InvestmentItemHeader extends StatelessWidget {
  const InvestmentItemHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white.withOpacity(0.2),
      child: const ListTile(
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
      ),
    );
  }
}
