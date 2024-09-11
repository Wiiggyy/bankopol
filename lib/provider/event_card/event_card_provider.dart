import 'dart:math';

import 'package:bankopol/constants/event_cards.dart';
import 'package:bankopol/enums/investment_type.dart';
import 'package:bankopol/models/event_card.dart';
import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/models/investment.dart';
import 'package:bankopol/models/player.dart';
import 'package:flutter/material.dart';

class EventCardProvider with ChangeNotifier {
  final GameState? gameState;

  EventCard? _currentEventCard;

  EventCardProvider({
    this.gameState,
  });

  EventCard? get currentEventCard => _currentEventCard;

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

      _currentEventCard = eventCards[randomIndex];
      notifyListeners();
    }
  }
}
