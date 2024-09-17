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
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'game_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentPlayer extends _$CurrentPlayer {
  late SharedPreferences _preferences;
  late String? _playerId;

  @override
  Future<Player?> build() async {
    try {
      _preferences = await SharedPreferences.getInstance();
      _playerId = _preferences.getString('id');

      final gameState = await ref.read(gameStatePodProvider.future);

      final currentPlayer = gameState.players.firstWhereOrNull(
        (player) => player.id == _playerId,
      );

      if (currentPlayer == null) {
        await _preferences.remove('id');
      }

      listenGameState();

      return currentPlayer;
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  void listenGameState() {
    ref.listen(
      gameStatePodProvider,
      (_, newState) {
        switch (newState) {
          case AsyncData(value: final gameState?):
            final currentPlayer = gameState.players.firstWhereOrNull(
              (player) => player.id == _playerId,
            );

            if (currentPlayer == null) {
              _preferences.remove('id');
              state = const AsyncData(null);
            } else {
              state = AsyncData(currentPlayer);
            }
          case _:
            state = const AsyncData(null);
        }
      },
    );
  }

  Future<void> setPlayerId(String id) {
    _playerId = id;
    return _preferences.setString('id', id);
  }
}

@Riverpod(keepAlive: true)
class CurrentEventCard extends _$CurrentEventCard {
  @override
  EventCard? build() {
    return null;
  }

  set eventCard(EventCard eventCard) {
    state = eventCard;
  }

  void removeCard() {
    state = null;
  }
}

@Riverpod(keepAlive: true)
class GameStatePod extends _$GameStatePod {
  late Repository _repository;

  @override
  Stream<GameState> build() async* {
    _repository = ref.watch(repositoryProvider.notifier);
    yield* _repository.streamGameState();
  }

  Future<void> joinGame(String name) async {
    if (name.isEmpty) {
      // ignore: parameter_assignments
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
    await _repository.joinGame(player);

    ref.read(currentPlayerProvider.notifier).setPlayerId(player.id);
  }

  void generateCard() {
    final gameState = state.requireValue!;
    final investmentTypes = <InvestmentType>{
      for (final Player player in gameState.players)
        for (final Investment investment in player.investments)
          investment.investmentType,
    };

    if (investmentTypes.isEmpty) return;
    final randomIndex = Random().nextInt(investmentTypes.length);

    final randomCardIndex = Random().nextInt(2);

    final eventCard = eventCards
        .where(
          (eventCard) =>
              eventCard.eventAction.investmentType ==
              investmentTypes.elementAt(randomIndex),
        )
        .elementAt(randomCardIndex);

    ref.read(currentEventCardProvider.notifier).eventCard = eventCard;
  }

  void removeCard() {
    ref.read(currentEventCardProvider.notifier).removeCard();
  }

  Future<void> setPlayerName(String newName) async {
    final currentPlayer = await ref.read(currentPlayerProvider.future);
    return _repository.setPlayerName(currentPlayer!.id, newName);
  }

  void updatePlayers() {
    final gameState = state.requireValue!;

    final currentEventCard = ref.read(currentEventCardProvider);
    final investmentType = currentEventCard?.eventAction.investmentType;
    final amount = currentEventCard?.eventAction.amount;
    final amountValue = currentEventCard?.eventAction.amountValue;
    final percentValue = 1 + (currentEventCard?.eventAction.percentValue ?? 0);

    final playersWithInvestment = gameState.players
        .where(
          (player) => player.investments
              .where(
                (investment) => investment.investmentType == investmentType,
              )
              .toList()
              .isNotEmpty,
        )
        .toList();

    final updatedPlayersWithInvestments = playersWithInvestment.map((player) {
      final investment = player.investments.firstWhere(
        (investment) => investment.investmentType == investmentType,
      );

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
            .map(
              (investment) => investment.investmentType == investmentType
                  ? updatedInvestment
                  : investment,
            )
            .toSet(),
      );
    }).toSet();

    _repository.updateGameState(
      gameState.copyWith(
        players: {
          ...gameState.players
            ..removeWhere(playersWithInvestment.contains)
            ..addAll(updatedPlayersWithInvestments),
        },
      ),
    );
  }

  Future<void> buyInvestment(Investment newInvestment) async {
    final gameState = state.requireValue!;

    final currentPlayer = ref.read(currentPlayerProvider).requireValue!;

    final investment = currentPlayer.investments
        .where(
          (playerInvestment) =>
              playerInvestment.investmentType == newInvestment.investmentType,
        )
        .toList();

    if (investment.isNotEmpty) {
      final nextInvestment = investment.first.copyWith(
        quantity: investment.first.quantity + newInvestment.quantity,
        value: investment.first.value + newInvestment.value,
      );
      currentPlayer.investments.removeWhere(
        (playerInvestment) =>
            playerInvestment.investmentType == newInvestment.investmentType,
      );
      currentPlayer.investments.add(nextInvestment);
    } else {
      currentPlayer.investments.add(newInvestment);
    }

    final newBankAccount = currentPlayer.bankAccount.copyWith(
      amount: currentPlayer.bankAccount.amount - newInvestment.value,
    );

    final updatedPlayer = currentPlayer.copyWith(
      bankAccount: newBankAccount,
    );

    final nextGameState = gameState.copyWith(
      players: {...gameState.players}
        ..removeWhere((player) => player.id == currentPlayer.id)
        ..add(updatedPlayer),
    );
    await _repository.updateGameState(nextGameState);
  }

  Future<void> sellInvestment(Investment sellInvestment) async {
    final currentPlayer = ref.read(currentPlayerProvider).requireValue!;

    final investment = currentPlayer.investments.firstWhereOrNull(
      (playerInvestment) =>
          playerInvestment.investmentType == sellInvestment.investmentType,
    );

    if (investment == null) return;

    final newBankAccount = currentPlayer.bankAccount.copyWith(
      amount: currentPlayer.bankAccount.amount + sellInvestment.value,
    );

    final updatedPlayer = currentPlayer.copyWith(
      bankAccount: newBankAccount,
      investments: currentPlayer.investments
          .where(
            (playerInvestment) =>
                playerInvestment.investmentType !=
                sellInvestment.investmentType,
          )
          .toSet(),
    );

    final gameState = state.requireValue;

    final nextGameState = gameState!.copyWith(
      players: {...gameState.players}
        ..removeWhere((player) => player.id == currentPlayer.id)
        ..add(updatedPlayer),
    );
    await _repository.updateGameState(nextGameState);
  }
}
