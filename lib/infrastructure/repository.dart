import 'dart:convert';

import 'package:bankopol/enums/investment_type.dart';
import 'package:bankopol/models/bank_account.dart';
import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/models/investment.dart';
import 'package:bankopol/models/player.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class Repository {
  final WebSocketChannel _channel;
  final Dio _dio;

  const Repository._(this._channel, this._dio);

  factory Repository() {
    const uri =
        'ws://hackstatehandler-djcyf9c6bbetfvfy.swedencentral-01.azurewebsites.net/api/Player/connect/';
    print('Connecting to socket');
    final channel = WebSocketChannel.connect(Uri.parse(uri));
    final dio = Dio();
    return Repository._(channel, dio);
  }

  Stream<GameState> streamGameState() async* {
    await _channel.ready;
    print('Getting stream');

    await for (final message in _channel.stream) {
      print('Received: $message');
      if (message is String) {
        final jsonData = jsonDecode(message);
        final gameState = GameState.fromJson(jsonData);
        yield gameState;
      }
    }
  }

  Future<GameState?> getCurrentGameState() async {
    final response = await _dio.get(
        'https://hackstatehandler-djcyf9c6bbetfvfy.swedencentral-01.azurewebsites.net/api/Player/latestState');
    if (response.data case final String json?) {
      try {
        return GameState.fromJson(jsonDecode(json));
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> updateGameState(GameState gameState) async {
    await _channel.ready;

    try {
      _channel.sink.add(jsonEncode(gameState.toJson()));
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Player> joinGame([Player? player]) async {
    player ??= Player(
      id: Uuid().v4(),
      name: 'Z',
      bankAccount: BankAccount(
        amount: 1000,
        interest: 0.1,
      ),
      investments: {Investment.generateRandomInvestment()},
    );
    final currentGameState = await getCurrentGameState();
    print('Current game state: $currentGameState');
    print('Players: ${currentGameState?.players.length}');
    GameState nextGameState;
    if (currentGameState case final currentGameState?) {
      nextGameState = currentGameState.copyWith(
        players: currentGameState.players..add(player),
      );
    } else {
      nextGameState = GameState(
        players: {player},
      );
    }
    await _channel.ready;

    try {
      _channel.sink.add(jsonEncode(nextGameState.toJson()));
    } catch (e) {
      print('Error: $e');
    }
    return player;
  }

  Future<void> clearGame() async {
    await _channel.ready;

    _channel.sink.add(jsonEncode(const GameState(players: {}).toJson()));
  }
}
