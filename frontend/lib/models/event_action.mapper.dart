// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event_action.dart';

class EventActionMapper extends ClassMapperBase<EventAction> {
  EventActionMapper._();

  static EventActionMapper? _instance;
  static EventActionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventActionMapper._());
      InvestmentTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EventAction';

  static InvestmentType _$investmentType(EventAction v) => v.investmentType;
  static const Field<EventAction, InvestmentType> _f$investmentType =
      Field('investmentType', _$investmentType);
  static double? _$amountValue(EventAction v) => v.amountValue;
  static const Field<EventAction, double> _f$amountValue =
      Field('amountValue', _$amountValue, opt: true);
  static int? _$amount(EventAction v) => v.amount;
  static const Field<EventAction, int> _f$amount =
      Field('amount', _$amount, opt: true);
  static double? _$percentValue(EventAction v) => v.percentValue;
  static const Field<EventAction, double> _f$percentValue =
      Field('percentValue', _$percentValue, opt: true);

  @override
  final MappableFields<EventAction> fields = const {
    #investmentType: _f$investmentType,
    #amountValue: _f$amountValue,
    #amount: _f$amount,
    #percentValue: _f$percentValue,
  };

  static EventAction _instantiate(DecodingData data) {
    return EventAction(
        investmentType: data.dec(_f$investmentType),
        amountValue: data.dec(_f$amountValue),
        amount: data.dec(_f$amount),
        percentValue: data.dec(_f$percentValue));
  }

  @override
  final Function instantiate = _instantiate;

  static EventAction fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventAction>(map);
  }

  static EventAction fromJson(String json) {
    return ensureInitialized().decodeJson<EventAction>(json);
  }
}

mixin EventActionMappable {
  String toJson() {
    return EventActionMapper.ensureInitialized()
        .encodeJson<EventAction>(this as EventAction);
  }

  Map<String, dynamic> toMap() {
    return EventActionMapper.ensureInitialized()
        .encodeMap<EventAction>(this as EventAction);
  }

  EventActionCopyWith<EventAction, EventAction, EventAction> get copyWith =>
      _EventActionCopyWithImpl(this as EventAction, $identity, $identity);
  @override
  String toString() {
    return EventActionMapper.ensureInitialized()
        .stringifyValue(this as EventAction);
  }

  @override
  bool operator ==(Object other) {
    return EventActionMapper.ensureInitialized()
        .equalsValue(this as EventAction, other);
  }

  @override
  int get hashCode {
    return EventActionMapper.ensureInitialized().hashValue(this as EventAction);
  }
}

extension EventActionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventAction, $Out> {
  EventActionCopyWith<$R, EventAction, $Out> get $asEventAction =>
      $base.as((v, t, t2) => _EventActionCopyWithImpl(v, t, t2));
}

abstract class EventActionCopyWith<$R, $In extends EventAction, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {InvestmentType? investmentType,
      double? amountValue,
      int? amount,
      double? percentValue});
  EventActionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventActionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventAction, $Out>
    implements EventActionCopyWith<$R, EventAction, $Out> {
  _EventActionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventAction> $mapper =
      EventActionMapper.ensureInitialized();
  @override
  $R call(
          {InvestmentType? investmentType,
          Object? amountValue = $none,
          Object? amount = $none,
          Object? percentValue = $none}) =>
      $apply(FieldCopyWithData({
        if (investmentType != null) #investmentType: investmentType,
        if (amountValue != $none) #amountValue: amountValue,
        if (amount != $none) #amount: amount,
        if (percentValue != $none) #percentValue: percentValue
      }));
  @override
  EventAction $make(CopyWithData data) => EventAction(
      investmentType: data.get(#investmentType, or: $value.investmentType),
      amountValue: data.get(#amountValue, or: $value.amountValue),
      amount: data.get(#amount, or: $value.amount),
      percentValue: data.get(#percentValue, or: $value.percentValue));

  @override
  EventActionCopyWith<$R2, EventAction, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EventActionCopyWithImpl($value, $cast, t);
}
