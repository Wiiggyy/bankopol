// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event_card.dart';

class EventCardMapper extends ClassMapperBase<EventCard> {
  EventCardMapper._();

  static EventCardMapper? _instance;
  static EventCardMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventCardMapper._());
      EventActionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EventCard';

  static String _$description(EventCard v) => v.description;
  static const Field<EventCard, String> _f$description =
      Field('description', _$description);
  static EventAction _$eventAction(EventCard v) => v.eventAction;
  static const Field<EventCard, EventAction> _f$eventAction =
      Field('eventAction', _$eventAction);

  @override
  final MappableFields<EventCard> fields = const {
    #description: _f$description,
    #eventAction: _f$eventAction,
  };

  static EventCard _instantiate(DecodingData data) {
    return EventCard(
        description: data.dec(_f$description),
        eventAction: data.dec(_f$eventAction));
  }

  @override
  final Function instantiate = _instantiate;

  static EventCard fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventCard>(map);
  }

  static EventCard fromJson(String json) {
    return ensureInitialized().decodeJson<EventCard>(json);
  }
}

mixin EventCardMappable {
  String toJson() {
    return EventCardMapper.ensureInitialized()
        .encodeJson<EventCard>(this as EventCard);
  }

  Map<String, dynamic> toMap() {
    return EventCardMapper.ensureInitialized()
        .encodeMap<EventCard>(this as EventCard);
  }

  EventCardCopyWith<EventCard, EventCard, EventCard> get copyWith =>
      _EventCardCopyWithImpl(this as EventCard, $identity, $identity);
  @override
  String toString() {
    return EventCardMapper.ensureInitialized()
        .stringifyValue(this as EventCard);
  }

  @override
  bool operator ==(Object other) {
    return EventCardMapper.ensureInitialized()
        .equalsValue(this as EventCard, other);
  }

  @override
  int get hashCode {
    return EventCardMapper.ensureInitialized().hashValue(this as EventCard);
  }
}

extension EventCardValueCopy<$R, $Out> on ObjectCopyWith<$R, EventCard, $Out> {
  EventCardCopyWith<$R, EventCard, $Out> get $asEventCard =>
      $base.as((v, t, t2) => _EventCardCopyWithImpl(v, t, t2));
}

abstract class EventCardCopyWith<$R, $In extends EventCard, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  EventActionCopyWith<$R, EventAction, EventAction> get eventAction;
  $R call({String? description, EventAction? eventAction});
  EventCardCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventCardCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventCard, $Out>
    implements EventCardCopyWith<$R, EventCard, $Out> {
  _EventCardCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventCard> $mapper =
      EventCardMapper.ensureInitialized();
  @override
  EventActionCopyWith<$R, EventAction, EventAction> get eventAction =>
      $value.eventAction.copyWith.$chain((v) => call(eventAction: v));
  @override
  $R call({String? description, EventAction? eventAction}) =>
      $apply(FieldCopyWithData({
        if (description != null) #description: description,
        if (eventAction != null) #eventAction: eventAction
      }));
  @override
  EventCard $make(CopyWithData data) => EventCard(
      description: data.get(#description, or: $value.description),
      eventAction: data.get(#eventAction, or: $value.eventAction));

  @override
  EventCardCopyWith<$R2, EventCard, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EventCardCopyWithImpl($value, $cast, t);
}
