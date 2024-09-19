import 'package:bankopol/enums/investment_type.dart';
import 'package:bankopol/infrastructure/repository.dart';
import 'package:bankopol/models/event.dart';
import 'package:bankopol/models/event_card.dart';
import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/models/investment.dart';
import 'package:bankopol/provider/game/event_provider.dart';
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

@riverpod
class CurrentEventCard extends _$CurrentEventCard {
  @override
  EventCard? build() {
    final cardEvent = ref.watch(eventProvider<EventCardEvent>());
    if (cardEvent case AsyncData(value: final event)) return event.eventCard;
    return null;
  }

  set eventCard(EventCard eventCard) {
    state = eventCard;
  }

  EventCard? removeCard() {
    try {
      return state;
    } finally {
      state = null;
    }
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

  void generateCard() {
    _repository.generateEventCard();
  }

  void removeCardFromScreen() {
    ref.read(currentEventCardProvider.notifier).removeCard();
  }

  void activateEventCard() {
    final eventCard = ref.read(currentEventCardProvider);
    if (eventCard == null) return;

    _repository.activateEventCard(eventCard);
  }

  Future<void> setPlayerName(String newName) async {
    return _repository.setPlayerName(newName);
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
