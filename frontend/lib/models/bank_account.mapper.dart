// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bank_account.dart';

class BankAccountMapper extends ClassMapperBase<BankAccount> {
  BankAccountMapper._();

  static BankAccountMapper? _instance;
  static BankAccountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BankAccountMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BankAccount';

  static double _$amount(BankAccount v) => v.amount;
  static const Field<BankAccount, double> _f$amount = Field('amount', _$amount);
  static double _$interest(BankAccount v) => v.interest;
  static const Field<BankAccount, double> _f$interest =
      Field('interest', _$interest, opt: true, def: 0);

  @override
  final MappableFields<BankAccount> fields = const {
    #amount: _f$amount,
    #interest: _f$interest,
  };

  static BankAccount _instantiate(DecodingData data) {
    return BankAccount(
        amount: data.dec(_f$amount), interest: data.dec(_f$interest));
  }

  @override
  final Function instantiate = _instantiate;

  static BankAccount fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BankAccount>(map);
  }

  static BankAccount fromJson(String json) {
    return ensureInitialized().decodeJson<BankAccount>(json);
  }
}

mixin BankAccountMappable {
  String toJson() {
    return BankAccountMapper.ensureInitialized()
        .encodeJson<BankAccount>(this as BankAccount);
  }

  Map<String, dynamic> toMap() {
    return BankAccountMapper.ensureInitialized()
        .encodeMap<BankAccount>(this as BankAccount);
  }

  BankAccountCopyWith<BankAccount, BankAccount, BankAccount> get copyWith =>
      _BankAccountCopyWithImpl(this as BankAccount, $identity, $identity);
  @override
  String toString() {
    return BankAccountMapper.ensureInitialized()
        .stringifyValue(this as BankAccount);
  }

  @override
  bool operator ==(Object other) {
    return BankAccountMapper.ensureInitialized()
        .equalsValue(this as BankAccount, other);
  }

  @override
  int get hashCode {
    return BankAccountMapper.ensureInitialized().hashValue(this as BankAccount);
  }
}

extension BankAccountValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BankAccount, $Out> {
  BankAccountCopyWith<$R, BankAccount, $Out> get $asBankAccount =>
      $base.as((v, t, t2) => _BankAccountCopyWithImpl(v, t, t2));
}

abstract class BankAccountCopyWith<$R, $In extends BankAccount, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? amount, double? interest});
  BankAccountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BankAccountCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BankAccount, $Out>
    implements BankAccountCopyWith<$R, BankAccount, $Out> {
  _BankAccountCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BankAccount> $mapper =
      BankAccountMapper.ensureInitialized();
  @override
  $R call({double? amount, double? interest}) => $apply(FieldCopyWithData({
        if (amount != null) #amount: amount,
        if (interest != null) #interest: interest
      }));
  @override
  BankAccount $make(CopyWithData data) => BankAccount(
      amount: data.get(#amount, or: $value.amount),
      interest: data.get(#interest, or: $value.interest));

  @override
  BankAccountCopyWith<$R2, BankAccount, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BankAccountCopyWithImpl($value, $cast, t);
}
