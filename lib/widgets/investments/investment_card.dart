import 'package:bankopol/enums/investment_type.dart';
import 'package:bankopol/models/investment.dart';
import 'package:flutter/material.dart';

class InvestmentCard extends StatelessWidget {
  final Investment investment;

  const InvestmentCard({
    required this.investment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          // rounded corners image

          Positioned.fill(
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(12.0), // Adjust the radius as needed
              child: Image.asset(
                'assets/${investment.investmentType.name}.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Card with content
          ClipRRect(
            borderRadius:
                BorderRadius.circular(12.0), // Adjust the radius as needed
            child: Container(
              // margin: const EdgeInsets.all(32.0),
              width: double.infinity,
              padding: const EdgeInsets.all(32.0),
              color: Colors.white.withOpacity(0.6),
              // height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getInvestmentTypeName(investment.investmentType),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      shadows: [],
                    ),
                  ),
                  Text(
                    getInvestmentDescription(investment.investmentType),
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
                    'Ränta: ${investment.interest}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
