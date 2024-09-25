import 'dart:math';

import 'package:bankopol/enums/investment_type.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'investment.mapper.dart';

@MappableClass()
class Investment with InvestmentMappable {
  final InvestmentType investmentType;
  final double value;
  final int quantity;
  final double interest;

  const Investment({
    required this.investmentType,
    required this.value,
    required this.quantity,
    required this.interest,
  });

  static final random = Random();

  factory Investment.generateRandomInvestment() {
    final investmentType =
        InvestmentType.values[random.nextInt(InvestmentType.values.length)];
    final value = random.nextDouble() * 1000;
    const quantity = 1; //random.nextInt(100) + 1;
    final interest = random.nextDouble() * 0.2;

    return Investment(
      investmentType: investmentType,
      value: value,
      quantity: quantity,
      interest: interest,
    );
  }

  factory Investment.fromCode(String code) {
    final separated = code.split(':');
    switch (separated) {
      case ['event', final code]:
        final intCode = int.tryParse(code);
        if (intCode == null || intCode >= InvestmentType.values.length) {
          continue random;
        }
        final investmentType = InvestmentType.values[intCode];
        final value = random.nextDouble() * 1000;
        const quantity = 1; //random.nextInt(100) + 1;
        final interest = random.nextDouble() * 0.2;

        return Investment(
          investmentType: investmentType,
          value: value,
          quantity: quantity,
          interest: interest,
        );
      // "event:$event"
      random:
      case _:
        return Investment.generateRandomInvestment();
    }
  }
}
