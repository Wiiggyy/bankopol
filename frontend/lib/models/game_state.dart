import 'package:bankopol/models/player.dart';

class GameState {
  final Player player;
  final Set<Player> players;

  const GameState({
    required this.player,
    required this.players,
  });

  factory GameState.fromJson(Map<String, dynamic> json) {
    final players = (json['players'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(Player.fromJson)
        .toSet();

    final playerJson = json['player'] as Map<String, dynamic>;

    return GameState(players: players, player: Player.fromJson(playerJson));
  }

  GameState copyWith({
    Set<Player>? players,
  }) {
    return GameState(
      players: players ?? this.players,
      player: player,
    );
  }

  Map<String, List<Map<String, dynamic>>> toJson() {
    return {
      'players': players.map((player) => player.toJson()).toList(),
    };
  }
}
