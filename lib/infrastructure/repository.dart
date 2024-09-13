import 'dart:convert';

import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/models/player.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'repository.g.dart';

@riverpod
class Repository extends _$Repository {
  late WebSocketChannel _channel;
  late Dio _dio;

  @override
  void build() {
    const uri =
        'wss://hackstatehandler-djcyf9c6bbetfvfy.swedencentral-01.azurewebsites.net/api/Player/connect/';
    debugPrint('Connecting to socket');
    _channel = WebSocketChannel.connect(Uri.parse(uri));
    _dio = Dio();
  }

  Stream<GameState> streamGameState() async* {
    await _channel.ready;
    debugPrint('Getting stream');

    await for (final message in _channel.stream) {
      debugPrint('Received message');
      try {
        if (message is String) {
          final jsonData = jsonDecode(message);
          final gameState =
              GameState.fromJson(jsonData as Map<String, dynamic>);
          yield gameState;
        }
      } catch (e, stackTrace) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }

  Future<GameState?> getCurrentGameState() async {
    final response = await _dio.get(
      'https://hackstatehandler-djcyf9c6bbetfvfy.swedencentral-01.azurewebsites.net/api/Player/latestState',
    );
    if (response.data case final String json?) {
      try {
        return GameState.fromJson(jsonDecode(json) as Map<String, dynamic>);
      } catch (e, stackTrace) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: stackTrace);
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

  Future<Player> joinGame(Player player) async {
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
