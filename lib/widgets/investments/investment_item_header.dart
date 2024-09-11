import 'package:flutter/material.dart';

class InvestmentItemHeader extends StatelessWidget {
  const InvestmentItemHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Investering',
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Antal',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Värde',
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
