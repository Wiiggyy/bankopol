import 'package:bankopol/models/player.dart';

class GameState {
  final Set<Player> players;

  const GameState({
    required this.players,
  });

  factory GameState.fromJson(Map<String, dynamic> json) {
    final players = (json['players'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(Player.fromJson)
        .toSet();

    return GameState(
      players: players,
    );
  }

  GameState copyWith({
    Set<Player>? players,
  }) {
    return GameState(
      players: players ?? this.players,
    );
  }

  Map<String, List<Map<String, dynamic>>> toJson() {
    return {
      'players': players.map((player) => player.toJson()).toList(),
    };
  }
}
