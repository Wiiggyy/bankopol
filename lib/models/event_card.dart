import 'package:bankopol/models/event_action.dart';

class EventCard {
  final String description;
  final EventAction eventAction;

  const EventCard({
    required this.description,
    required this.eventAction,
  });
}
