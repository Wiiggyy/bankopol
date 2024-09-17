import 'dart:convert';

import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/models/player.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'repository.g.dart';

@Riverpod(keepAlive: true)
class Repository extends _$Repository {
  late WebSocketChannel _channel;
  late String _host;

  @override
  void build() {
    _host = 'localhost:7226';
    // 'hackstatehandler-djcyf9c6bbetfvfy.swedencentral-01.azurewebsites.net';
    final uri = 'wss://$_host/api/Player/connect/';
    debugPrint('Connecting to socket');
    _channel = WebSocketChannel.connect(Uri.parse(uri));
  }

  Stream<GameState> streamGameState() async* {
    await _channel.ready;
    debugPrint('Getting stream');

    await for (final message in _channel.stream) {
      debugPrint('Received message');
      try {
        if (message is String) {
          final jsonData = jsonDecode(message);

          switch (jsonData) {
            case {
                'action': 'newGameState',
                'data': final Map<String, dynamic> data
              }:
              yield GameState.fromJson(data);
          }
        }
      } catch (e, stackTrace) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: stackTrace);
      }
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
    // debugPrint('Current game state: $currentGameState');
    // debugPrint('Players: ${currentGameState?.players.length}');
    // GameState nextGameState;
    // if (currentGameState case final currentGameState?) {
    // nextGameState = currentGameState.copyWith(
    //   players: currentGameState.players..add(player),
    // );
    // } else {
    //   nextGameState = GameState(
    //     players: {player},
    //   );
    // }
    _sendEventToServer('addPlayer', player.toJson());
    return player;
  }

  Future<void> setPlayerName(String playerId, String newName) async {
    await _channel.ready;
    _sendEventToServer('updatePlayerName', {
      'id': playerId,
      'name': newName,
    });
  }

  Future<void> _sendEventToServer(
    String action,
    Map<String, dynamic> data,
  ) async {
    await _channel.ready;
    try {
      _channel.sink.add(
        jsonEncode({
          'action': action,
          'data': data,
        }),
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> clearGame() async {
    await _channel.ready;

    _channel.sink.add(jsonEncode(const GameState(players: {}).toJson()));
  }
}
