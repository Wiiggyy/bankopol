// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'player.dart';

class PlayerMapper extends ClassMapperBase<Player> {
  PlayerMapper._();

  static PlayerMapper? _instance;
  static PlayerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlayerMapper._());
      BankAccountMapper.ensureInitialized();
      InvestmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Player';

  static String _$id(Player v) => v.id;
  static const Field<Player, String> _f$id = Field('id', _$id);
  static String _$name(Player v) => v.name;
  static const Field<Player, String> _f$name = Field('name', _$name);
  static BankAccount _$bankAccount(Player v) => v.bankAccount;
  static const Field<Player, BankAccount> _f$bankAccount =
      Field('bankAccount', _$bankAccount);
  static Set<Investment> _$investments(Player v) => v.investments;
  static const Field<Player, Set<Investment>> _f$investments =
      Field('investments', _$investments);
  static Set<int> _$scannedCodes(Player v) => v.scannedCodes;
  static const Field<Player, Set<int>> _f$scannedCodes =
      Field('scannedCodes', _$scannedCodes, opt: true, def: const {});

  @override
  final MappableFields<Player> fields = const {
    #id: _f$id,
    #name: _f$name,
    #bankAccount: _f$bankAccount,
    #investments: _f$investments,
    #scannedCodes: _f$scannedCodes,
  };

  static Player _instantiate(DecodingData data) {
    return Player(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        bankAccount: data.dec(_f$bankAccount),
        investments: data.dec(_f$investments),
        scannedCodes: data.dec(_f$scannedCodes));
  }

  @override
  final Function instantiate = _instantiate;

  static Player fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Player>(map);
  }

  static Player fromJson(String json) {
    return ensureInitialized().decodeJson<Player>(json);
  }
}

mixin PlayerMappable {
  String toJson() {
    return PlayerMapper.ensureInitialized().encodeJson<Player>(this as Player);
  }

  Map<String, dynamic> toMap() {
    return PlayerMapper.ensureInitialized().encodeMap<Player>(this as Player);
  }

  PlayerCopyWith<Player, Player, Player> get copyWith =>
      _PlayerCopyWithImpl(this as Player, $identity, $identity);
  @override
  String toString() {
    return PlayerMapper.ensureInitialized().stringifyValue(this as Player);
  }

  @override
  bool operator ==(Object other) {
    return PlayerMapper.ensureInitialized().equalsValue(this as Player, other);
  }

  @override
  int get hashCode {
    return PlayerMapper.ensureInitialized().hashValue(this as Player);
  }
}

extension PlayerValueCopy<$R, $Out> on ObjectCopyWith<$R, Player, $Out> {
  PlayerCopyWith<$R, Player, $Out> get $asPlayer =>
      $base.as((v, t, t2) => _PlayerCopyWithImpl(v, t, t2));
}

abstract class PlayerCopyWith<$R, $In extends Player, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BankAccountCopyWith<$R, BankAccount, BankAccount> get bankAccount;
  $R call(
      {String? id,
      String? name,
      BankAccount? bankAccount,
      Set<Investment>? investments,
      Set<int>? scannedCodes});
  PlayerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlayerCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Player, $Out>
    implements PlayerCopyWith<$R, Player, $Out> {
  _PlayerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Player> $mapper = PlayerMapper.ensureInitialized();
  @override
  BankAccountCopyWith<$R, BankAccount, BankAccount> get bankAccount =>
      $value.bankAccount.copyWith.$chain((v) => call(bankAccount: v));
  @override
  $R call(
          {String? id,
          String? name,
          BankAccount? bankAccount,
          Set<Investment>? investments,
          Set<int>? scannedCodes}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (bankAccount != null) #bankAccount: bankAccount,
        if (investments != null) #investments: investments,
        if (scannedCodes != null) #scannedCodes: scannedCodes
      }));
  @override
  Player $make(CopyWithData data) => Player(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      bankAccount: data.get(#bankAccount, or: $value.bankAccount),
      investments: data.get(#investments, or: $value.investments),
      scannedCodes: data.get(#scannedCodes, or: $value.scannedCodes));

  @override
  PlayerCopyWith<$R2, Player, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PlayerCopyWithImpl($value, $cast, t);
}
