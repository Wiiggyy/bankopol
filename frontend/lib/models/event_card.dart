import 'package:bankopol/models/event_action.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'event_card.mapper.dart';

@MappableClass()
class EventCard with EventCardMappable {
  final String description;
  final EventAction eventAction;

  const EventCard({
    required this.description,
    required this.eventAction,
  });
}
