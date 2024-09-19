import 'package:bankopol/models/player.dart';

class GameState {
  final Player player;
  final Map<String, num> highScore;

  const GameState({
    required this.player,
    required this.highScore,
  });

  factory GameState.fromJson(Map<String, dynamic> json) {
    final playerJson = json['player'] as Map<String, dynamic>;
    final highScore = json['highScore'] as Map<String, dynamic>;

    return GameState(
      player: Player.fromJson(playerJson),
      highScore: highScore.cast(),
    );
  }
}
