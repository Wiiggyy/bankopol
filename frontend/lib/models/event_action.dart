import 'package:bankopol/enums/investment_type.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'event_action.mapper.dart';

@MappableClass()
class EventAction with EventActionMappable {
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
