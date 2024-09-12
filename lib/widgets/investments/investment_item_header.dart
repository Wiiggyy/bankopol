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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
      title: Text(
        'Antal',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      trailing: Text(
        'Värde',
        textAlign: TextAlign.right,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
