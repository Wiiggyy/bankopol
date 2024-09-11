import 'dart:convert';

import 'package:bankopol/models/bank_account.dart';
import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/models/investment.dart';
import 'package:bankopol/models/player.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Repository {
  final WebSocketChannel _channel;
  final Dio _dio;

  const Repository._(this._channel, this._dio);

  factory Repository() {
    const uri =
        'ws://hackstatehandler-djcyf9c6bbetfvfy.swedencentral-01.azurewebsites.net/api/Player/connect/';
    debugPrint('Connecting to socket');
    final channel = WebSocketChannel.connect(Uri.parse(uri));
    final dio = Dio();
    return Repository._(channel, dio);
  }

  Stream<GameState> streamGameState() async* {
    await _channel.ready;
    debugPrint('Getting stream');

    await for (final message in _channel.stream) {
      debugPrint('Received: $message');
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
      debugPrint('Error: $e');
    }
  }

  Future<Player> joinGame([Player? player]) async {
    player ??= Player(
      id: const Uuid().v4(),
      name: 'Z',
      bankAccount: const BankAccount(
        amount: 1000,
        interest: 1000,
      ),
      investments: {Investment.generateRandomInvestment()},
    );
    final currentGameState = await getCurrentGameState();
    debugPrint('Current game state: $currentGameState');
    debugPrint('Players: ${currentGameState?.players.length}');
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
      debugPrint('Error: $e');
    }
    return player;
  }

  Future<void> clearGame() async {
    await _channel.ready;

    _channel.sink.add(jsonEncode(const GameState(players: {}).toJson()));
  }
}
