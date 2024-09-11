import 'package:bankopol/enums/investment_type.dart';

class EventAction {
  final InvestmentType investmentType;
  final double? amountValue;
  final double? percentValue;
  final int? amount;

  const EventAction({
    required this.investmentType,
    this.amountValue,
    this.amount,
    this.percentValue,
  }) : assert(
          !(amountValue != null && percentValue != null && amount != null),
          'amountValue and percentValue or amount cannot both have a value',
        );
}
