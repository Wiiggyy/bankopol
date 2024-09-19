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

  factory EventAction.fromJson(Map<String, dynamic> json) {
    return EventAction(
      investmentType: InvestmentType.values[json['investmentType'] as int],
      amountValue: (json['amountValue'] as num?)?.toDouble(),
      percentValue: (json['percentValue'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
        'investmentType': investmentType.index,
        'amountValue': amountValue,
        'amount': amount,
        'percentValue': percentValue,
      };
}
