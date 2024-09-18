import 'dart:async';
import 'dart:convert';

import 'package:bankopol/enums/investment_type.dart';
import 'package:bankopol/models/event.dart';
import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/models/investment.dart';
import 'package:bankopol/models/player.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'repository.g.dart';

@Riverpod(keepAlive: true)
class Repository extends _$Repository {
  late WebSocketChannel _channel;
  late String _host;

  late StreamController<GameState> _gameStateController;
  late StreamController<Event> _eventController;

  @override
  void build() {
    _gameStateController = StreamController();
    _eventController = StreamController();

    ref.onDispose(_gameStateController.close);
    ref.onDispose(_eventController.close);

    _host = 'localhost:7226';
    // 'hackstatehandler-djcyf9c6bbetfvfy.swedencentral-01.azurewebsites.net';
    final uri = 'wss://$_host/api/Player/connect/';
    debugPrint('Connecting to socket');
    _channel = WebSocketChannel.connect(Uri.parse(uri));

    _connectToServer();
  }

  Future<void> _connectToServer() async {
    debugPrint('Getting stream');
    await _channel.ready;

    _sendEventToServer('join', ref.read(playerIdProvider));

    await for (final message in _channel.stream) {
      debugPrint('Received message');
      try {
        if (message is String) {
          final jsonData = jsonDecode(message);

          switch (jsonData) {
            case {
                'action': 'newGameState',
                'data': final Map<String, dynamic> data,
              }:
              _gameStateController.add(GameState.fromJson(data));
            case {
                'action': 'investmentOpportunity',
                'data': final Map<String, dynamic> data,
              }:
              _eventController.add(
                InvestmentOpportunityEvent(Investment.fromJson(data)),
              );
            case final _:
              debugPrint('No action set up for $message');
          }
        }
      } catch (e, stackTrace) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }

  Stream<Event> streamEvents() {
    return _eventController.stream;
  }

  Stream<GameState> streamGameState() {
    return _gameStateController.stream;
  }

  Future<void> updateGameState(GameState gameState) async {
    await _channel.ready;

    try {
      _channel.sink.add(jsonEncode(gameState.toJson()));
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Player joinGame(Player player) {
    _sendEventToServer('addPlayer', player.toJson());
    return player;
  }

  void setPlayerName(String newName) {
    _sendEventToServer('updatePlayerName', {
      'name': newName,
    });
  }

  void fetchInvestment(InvestmentType investmentType) {
    _sendEventToServer(
      'fetchInvestment',
      investmentType.index,
    );
  }

  void generateEventCard() {
    _sendEventToServer('generateEventCard');
  }

  void buyInvestment(Investment newInvestment) {
    _sendEventToServer('buyInvestment', newInvestment.toJson());
  }

  Future<void> _sendEventToServer(
    String action, [
    Object? data,
  ]) async {
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

    _sendEventToServer('clearGame');
  }
}
