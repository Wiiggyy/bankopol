import 'package:bankopol/models/player.dart';

class GameState {
  final Set<Player> players;

  const GameState({
    required this.players,
  });

  factory GameState.fromJson(Map<String, dynamic> json) {
    final players = (json['players'] as List)
        .map((player) => Player.fromJson(player))
        .toSet();

    return GameState(
      players: players,
    );
  }

  copyWith({
    Set<Player>? players,
  }) {
    return GameState(
      players: players ?? this.players,
    );
  }

  toJson() {
    return {
      'players': players.map((player) => player.toJson()).toList(),
    };
  }
}
