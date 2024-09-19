import 'package:bankopol/models/player.dart';

class GameState {
  final Player player;

  const GameState({
    required this.player,
  });

  factory GameState.fromJson(Map<String, dynamic> json) {
    final playerJson = json['player'] as Map<String, dynamic>;

    return GameState(player: Player.fromJson(playerJson));
  }

  GameState copyWith({
    Set<Player>? players,
  }) {
    return GameState(
      player: player,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player': player.toJson(),
    };
  }
}
