// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'game_state.dart';

class GameStateMapper extends ClassMapperBase<GameState> {
  GameStateMapper._();

  static GameStateMapper? _instance;
  static GameStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameStateMapper._());
      PlayerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameState';

  static Player _$player(GameState v) => v.player;
  static const Field<GameState, Player> _f$player = Field('player', _$player);
  static Map<String, num> _$highScore(GameState v) => v.highScore;
  static const Field<GameState, Map<String, num>> _f$highScore =
      Field('highScore', _$highScore);

  @override
  final MappableFields<GameState> fields = const {
    #player: _f$player,
    #highScore: _f$highScore,
  };

  static GameState _instantiate(DecodingData data) {
    return GameState(
        player: data.dec(_f$player), highScore: data.dec(_f$highScore));
  }

  @override
  final Function instantiate = _instantiate;

  static GameState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameState>(map);
  }

  static GameState fromJson(String json) {
    return ensureInitialized().decodeJson<GameState>(json);
  }
}

mixin GameStateMappable {
  String toJson() {
    return GameStateMapper.ensureInitialized()
        .encodeJson<GameState>(this as GameState);
  }

  Map<String, dynamic> toMap() {
    return GameStateMapper.ensureInitialized()
        .encodeMap<GameState>(this as GameState);
  }

  GameStateCopyWith<GameState, GameState, GameState> get copyWith =>
      _GameStateCopyWithImpl(this as GameState, $identity, $identity);
  @override
  String toString() {
    return GameStateMapper.ensureInitialized()
        .stringifyValue(this as GameState);
  }

  @override
  bool operator ==(Object other) {
    return GameStateMapper.ensureInitialized()
        .equalsValue(this as GameState, other);
  }

  @override
  int get hashCode {
    return GameStateMapper.ensureInitialized().hashValue(this as GameState);
  }
}

extension GameStateValueCopy<$R, $Out> on ObjectCopyWith<$R, GameState, $Out> {
  GameStateCopyWith<$R, GameState, $Out> get $asGameState =>
      $base.as((v, t, t2) => _GameStateCopyWithImpl(v, t, t2));
}

abstract class GameStateCopyWith<$R, $In extends GameState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PlayerCopyWith<$R, Player, Player> get player;
  MapCopyWith<$R, String, num, ObjectCopyWith<$R, num, num>> get highScore;
  $R call({Player? player, Map<String, num>? highScore});
  GameStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameState, $Out>
    implements GameStateCopyWith<$R, GameState, $Out> {
  _GameStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameState> $mapper =
      GameStateMapper.ensureInitialized();
  @override
  PlayerCopyWith<$R, Player, Player> get player =>
      $value.player.copyWith.$chain((v) => call(player: v));
  @override
  MapCopyWith<$R, String, num, ObjectCopyWith<$R, num, num>> get highScore =>
      MapCopyWith($value.highScore, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(highScore: v));
  @override
  $R call({Player? player, Map<String, num>? highScore}) =>
      $apply(FieldCopyWithData({
        if (player != null) #player: player,
        if (highScore != null) #highScore: highScore
      }));
  @override
  GameState $make(CopyWithData data) => GameState(
      player: data.get(#player, or: $value.player),
      highScore: data.get(#highScore, or: $value.highScore));

  @override
  GameStateCopyWith<$R2, GameState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameStateCopyWithImpl($value, $cast, t);
}
