import 'package:bankopol/models/event_card.dart';
import 'package:bankopol/models/investment.dart';

sealed class Event {
  const Event();
}

final class InvestmentOpportunityEvent extends Event {
  final Investment investment;

  const InvestmentOpportunityEvent(this.investment);
}

final class EventCardEvent extends Event {
  final EventCard eventCard;

  const EventCardEvent(this.eventCard);
}
