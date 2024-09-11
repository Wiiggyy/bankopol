import 'dart:math';

import 'package:bankopol/constants/event_cards.dart';
import 'package:bankopol/enums/investment_type.dart';
import 'package:bankopol/infrastructure/repository.dart';
import 'package:bankopol/models/bank_account.dart';
import 'package:bankopol/models/event_card.dart';
import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/models/investment.dart';
import 'package:bankopol/models/player.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class GameProvider with ChangeNotifier {
  final Repository repository = Repository();
  // late Stream<GameState> gameStateStream;
  GameState? _gameState;
  EventCard? _currentEventCard;
  String? _currentPlayerId;

  GameProvider() {
    final gameStateStream = repository.streamGameState().asBroadcastStream();
    gameStateStream.listen((state) {
      _gameState = state;
      print('GameProvider1222: $state');
      notifyListeners();
    });
  }

  GameState? get gameState => _gameState;
  EventCard? get currentEventCard => _currentEventCard;
  Player? get currentPlayer {
    if (gameState case final gameState?) {
      return gameState.players.firstWhereOrNull(
        (player) => player.id == _currentPlayerId,
      );
    }
    return null;
  }

  void setState() {
    // final response = repository.streamGameState();
    notifyListeners();
  }

  Future<void> joinGame() async {
    final player = Player(
      id: Uuid().v4(),
      name: 'Z',
      bankAccount: BankAccount(
        amount: 5000,
        interest: 0.025,
      ),
      investments: [],
    );
    await repository.joinGame(player);
    _currentPlayerId = player.id;
    notifyListeners();
  }

  void generateCard() {
    Set<InvestmentType> investmentTypes = {};

    if (gameState case final gameState?) {
      print(11113);
      for (final Player player in gameState.players) {
        for (final Investment investment in player.investments) {
          investmentTypes.add(investment.investmentType);
        }
      }

      int randomIndex = Random().nextInt(investmentTypes.length);

      int randomCardIndex = Random().nextInt(2);

      _currentEventCard = eventCards
          .where(
            (eventCard) =>
                eventCard.eventAction.investmentType ==
                investmentTypes.elementAt(randomIndex),
          )
          .elementAt(randomCardIndex);

      notifyListeners();
    }
  }
}
