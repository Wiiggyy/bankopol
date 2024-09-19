import 'package:bankopol/models/event_action.dart';

class EventCard {
  final String description;
  final EventAction eventAction;

  const EventCard({
    required this.description,
    required this.eventAction,
  });

  factory EventCard.fromJson(Map<String, dynamic> json) {
    return EventCard(
      description: json['description'] as String,
      eventAction: EventAction.fromJson(
        json['eventAction'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'description': description,
        'eventAction': eventAction.toJson(),
      };
}
