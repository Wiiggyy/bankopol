import 'package:bankopol/enums/investment_type.dart';
import 'package:bankopol/infrastructure/repository.dart';
import 'package:bankopol/models/event_card.dart';
import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/models/investment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'game_provider.g.dart';

@riverpod
Future<String> playerId(PlayerIdRef ref) async {
  final prefs = await SharedPreferences.getInstance();

  var id = prefs.getString('id');
  if (id != null) return id;

  id = const Uuid().v4();
  prefs.setString('id', id);
  return id;
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

  // Future<void> joinGame(String name) async {
  //   if (name.isEmpty) {
  //     // ignore: parameter_assignments
  //     name =
  //         'Player ${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}';
  //   }
  //   final player = Player(
  //     id: const Uuid().v4(),
  //     name: name,
  //     bankAccount: const BankAccount(
  //       amount: 2000,
  //       interest: 0.025,
  //     ),
  //     investments: {},
  //   );
  //   await _repository.joinGame(player);
  //
  //   ref.read(currentPlayerProvider.notifier).setPlayerId(player.id);
  // }

  void generateCard() {
    _repository.generateEventCard();
  }

  void removeCard() {
    ref.read(currentEventCardProvider.notifier).removeCard();
  }

  Future<void> setPlayerName(String newName) async {
    return _repository.setPlayerName(newName);
  }

  void updatePlayers() {
    final gameState = state.requireValue;

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

  void fetchInvestment(InvestmentType type) {
    return _repository.fetchInvestment(type);
  }

  void buyInvestment(Investment newInvestment) {
    _repository.buyInvestment(newInvestment);
  }

  Future<void> sellInvestment(Investment sellInvestment) async {
    // final currentPlayer = ref.read(currentPlayerProvider).requireValue!;
    //
    // final investment = currentPlayer.investments.firstWhereOrNull(
    //   (playerInvestment) =>
    //       playerInvestment.investmentType == sellInvestment.investmentType,
    // );
    //
    // if (investment == null) return;
    //
    // final newBankAccount = currentPlayer.bankAccount.copyWith(
    //   amount: currentPlayer.bankAccount.amount + sellInvestment.value,
    // );
    //
    // final updatedPlayer = currentPlayer.copyWith(
    //   bankAccount: newBankAccount,
    //   investments: currentPlayer.investments
    //       .where(
    //         (playerInvestment) =>
    //             playerInvestment.investmentType !=
    //             sellInvestment.investmentType,
    //       )
    //       .toSet(),
    // );
    //
    // final gameState = state.requireValue;
    //
    // final nextGameState = gameState.copyWith(
    //   players: {...gameState.players}
    //     ..removeWhere((player) => player.id == currentPlayer.id)
    //     ..add(updatedPlayer),
    // );
    // await _repository.updateGameState(nextGameState);
  }
}
