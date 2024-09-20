import 'package:bankopol/constants/text_style.dart';
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
          onTap: () {
            showModalBottomSheet(
              useSafeArea: true,
              context: context,
              builder: (context) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/${investment.investmentType.name}.webp',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32.0),
                        color: Colors.white.withOpacity(0.8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              investment.investmentType.typeName,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                shadows: [],
                              ),
                            ),
                            Text(
                              investment.investmentType.description,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Antal: ${investment.quantity}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Pris: ${investment.value.toInt()}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          leading: Text(
            investment.investmentType.typeName,
            textAlign: TextAlign.left,
            style: investmentListTextStyle,
          ),
          trailing: Text(
            '${(investment.value * investment.quantity).toStringAsFixed(0)} (${investment.quantity})',
            textAlign: TextAlign.right,
            style: investmentListTextStyle,
          ),
        ),
      ],
    );
  }
}
