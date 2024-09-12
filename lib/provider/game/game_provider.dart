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

  Future<void> joinGame(String name) async {
    if (name.isEmpty) {
      name =
          'Player ${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}';
    }
    final player = Player(
      id: const Uuid().v4(),
      name: name,
      bankAccount: const BankAccount(
        amount: 2000,
        interest: 0.025,
      ),
      investments: {},
    );
    await repository.joinGame(player);
    _currentPlayerId = player.id;
    notifyListeners();
  }

  void generateCard() {
    if (gameState case final gameState?) {
      Set<InvestmentType> investmentTypes = {
        for (final Player player in gameState.players)
          for (final Investment investment in player.investments)
            investment.investmentType,
      };

      if (investmentTypes.isEmpty) return;
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

  void sellInvestment(Investment sellInvestment) async {
    if (gameState case final gameState?) {
      final player = gameState.players.firstWhereOrNull(
        (player) => player.id == _currentPlayerId,
      );

      if (player != null) {
        final investment = player.investments.firstWhereOrNull(
          (playerInvestment) =>
              playerInvestment.investmentType == sellInvestment.investmentType,
        );

        if (investment == null) return;

        final newBankAccount = player.bankAccount.copyWith(
          amount: player.bankAccount.amount + sellInvestment.value,
        );

        final updatedPlayer = player.copyWith(
          bankAccount: newBankAccount,
          investments: player.investments
              .where((playerInvestment) =>
                  playerInvestment.investmentType !=
                  sellInvestment.investmentType)
              .toSet(),
        );

        final nextGameState = gameState.copyWith(
          players: {...gameState.players}
            ..removeWhere((player) => player.id == _currentPlayerId)
            ..add(updatedPlayer),
        );
        await repository.updateGameState(nextGameState);
      }
    }
  }

  void buyInvestment(Investment newInvestment) async {
    if (gameState case final gameState?) {
      final player = gameState.players.firstWhereOrNull(
        (player) => player.id == _currentPlayerId,
      );

      if (player != null) {
        final investment = player.investments
            .where((playerInvestment) =>
                playerInvestment.investmentType == newInvestment.investmentType)
            .toList();

        if (investment.isNotEmpty) {
          final nextInvestment = investment.first.copyWith(
            quantity: investment.first.quantity + newInvestment.quantity,
            value: investment.first.value + newInvestment.value,
          );
          player.investments.removeWhere((playerInvestment) =>
              playerInvestment.investmentType == newInvestment.investmentType);
          player.investments.add(nextInvestment);
        } else {
          player.investments.add(newInvestment);
        }

        final newBankAccount = player.bankAccount.copyWith(
          amount: player.bankAccount.amount - newInvestment.value,
        );

        final updatedPlayer = player.copyWith(
          bankAccount: newBankAccount,
        );

        final nextGameState = gameState.copyWith(
          players: {...gameState.players}
            ..removeWhere((player) => player.id == _currentPlayerId)
            ..add(updatedPlayer),
        );
        await repository.updateGameState(nextGameState);
      }
    }
  }

  void updatePlayers() {
    final investmentType = _currentEventCard?.eventAction.investmentType;
    final amount = _currentEventCard?.eventAction.amount;
    final amountValue = _currentEventCard?.eventAction.amountValue;
    final percentValue = 1 + (_currentEventCard?.eventAction.percentValue ?? 0);

    final playersWithInvestment = gameState?.players
        .where((player) => player.investments
            .where(
              (investment) => investment.investmentType == investmentType,
            )
            .toList()
            .isNotEmpty)
        .toList();

    final updatedPlayersWithInvestments = playersWithInvestment?.map((player) {
      final investment = player.investments.firstWhere(
          (investment) => investment.investmentType == investmentType);

      final newQuantity = investment.quantity + (amount ?? 0);
      final newAmount = amountValue != null
          ? investment.value + amountValue
          : investment.value * percentValue;
      late Investment updatedInvestment;
      if (newQuantity == 0 || newAmount <= 0) {
        player.investments.remove(investment);
      } else {
        updatedInvestment = investment.copyWith(
          quantity: newQuantity,
          value: amountValue != null
              ? investment.value + amountValue
              : investment.value * percentValue,
        );
      }

      return player.copyWith(
          investments: player.investments
              .map((investment) => investment.investmentType == investmentType
                  ? updatedInvestment
                  : investment)
              .toSet());
    }).toSet();

    repository.updateGameState(
      gameState!.copyWith(
        players: {
          ...gameState!.players
            ..removeWhere(
                (player) => playersWithInvestment?.contains(player) ?? false)
            ..addAll(updatedPlayersWithInvestments ?? {}),
        },
      ),
    );
  }

  void removeCard() {
    _currentEventCard = null;
    notifyListeners();
  }

  void clearGameState() {
    _gameState = null;
    _currentEventCard = null;
    _currentPlayerId = null;

    repository.clearGame();
  }
}
