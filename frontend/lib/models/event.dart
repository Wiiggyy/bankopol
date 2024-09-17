import 'package:bankopol/models/investment.dart';

sealed class Event {
  const Event();
}

final class InvestmentOpportunityEvent extends Event {
  final Investment investment;

  const InvestmentOpportunityEvent(this.investment);
}
