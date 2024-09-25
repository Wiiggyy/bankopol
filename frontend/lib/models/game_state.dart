import 'package:bankopol/models/player.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'game_state.mapper.dart';

@MappableClass()
class GameState with GameStateMappable {
  final Player player;
  final Map<String, num> highScore;

  const GameState({
    required this.player,
    required this.highScore,
  });
}
