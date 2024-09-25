// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'investment.dart';

class InvestmentMapper extends ClassMapperBase<Investment> {
  InvestmentMapper._();

  static InvestmentMapper? _instance;
  static InvestmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InvestmentMapper._());
      InvestmentTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Investment';

  static InvestmentType _$investmentType(Investment v) => v.investmentType;
  static const Field<Investment, InvestmentType> _f$investmentType =
      Field('investmentType', _$investmentType);
  static double _$value(Investment v) => v.value;
  static const Field<Investment, double> _f$value = Field('value', _$value);
  static int _$quantity(Investment v) => v.quantity;
  static const Field<Investment, int> _f$quantity =
      Field('quantity', _$quantity);
  static double _$interest(Investment v) => v.interest;
  static const Field<Investment, double> _f$interest =
      Field('interest', _$interest);

  @override
  final MappableFields<Investment> fields = const {
    #investmentType: _f$investmentType,
    #value: _f$value,
    #quantity: _f$quantity,
    #interest: _f$interest,
  };

  static Investment _instantiate(DecodingData data) {
    return Investment(
        investmentType: data.dec(_f$investmentType),
        value: data.dec(_f$value),
        quantity: data.dec(_f$quantity),
        interest: data.dec(_f$interest));
  }

  @override
  final Function instantiate = _instantiate;

  static Investment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Investment>(map);
  }

  static Investment fromJson(String json) {
    return ensureInitialized().decodeJson<Investment>(json);
  }
}

mixin InvestmentMappable {
  String toJson() {
    return InvestmentMapper.ensureInitialized()
        .encodeJson<Investment>(this as Investment);
  }

  Map<String, dynamic> toMap() {
    return InvestmentMapper.ensureInitialized()
        .encodeMap<Investment>(this as Investment);
  }

  InvestmentCopyWith<Investment, Investment, Investment> get copyWith =>
      _InvestmentCopyWithImpl(this as Investment, $identity, $identity);
  @override
  String toString() {
    return InvestmentMapper.ensureInitialized()
        .stringifyValue(this as Investment);
  }

  @override
  bool operator ==(Object other) {
    return InvestmentMapper.ensureInitialized()
        .equalsValue(this as Investment, other);
  }

  @override
  int get hashCode {
    return InvestmentMapper.ensureInitialized().hashValue(this as Investment);
  }
}

extension InvestmentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Investment, $Out> {
  InvestmentCopyWith<$R, Investment, $Out> get $asInvestment =>
      $base.as((v, t, t2) => _InvestmentCopyWithImpl(v, t, t2));
}

abstract class InvestmentCopyWith<$R, $In extends Investment, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {InvestmentType? investmentType,
      double? value,
      int? quantity,
      double? interest});
  InvestmentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _InvestmentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Investment, $Out>
    implements InvestmentCopyWith<$R, Investment, $Out> {
  _InvestmentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Investment> $mapper =
      InvestmentMapper.ensureInitialized();
  @override
  $R call(
          {InvestmentType? investmentType,
          double? value,
          int? quantity,
          double? interest}) =>
      $apply(FieldCopyWithData({
        if (investmentType != null) #investmentType: investmentType,
        if (value != null) #value: value,
        if (quantity != null) #quantity: quantity,
        if (interest != null) #interest: interest
      }));
  @override
  Investment $make(CopyWithData data) => Investment(
      investmentType: data.get(#investmentType, or: $value.investmentType),
      value: data.get(#value, or: $value.value),
      quantity: data.get(#quantity, or: $value.quantity),
      interest: data.get(#interest, or: $value.interest));

  @override
  InvestmentCopyWith<$R2, Investment, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _InvestmentCopyWithImpl($value, $cast, t);
}
