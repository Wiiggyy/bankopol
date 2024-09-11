import 'dart:math';

import 'package:bankopol/constants/colors.dart';
import 'package:bankopol/constants/event_cards.dart';
import 'package:bankopol/enums/investment_type.dart';
import 'package:bankopol/infrastructure/repository.dart';
import 'package:bankopol/models/bank_account.dart';
import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/models/investment.dart';
import 'package:bankopol/models/player.dart';
import 'package:bankopol/provider/event_card/event_card_provider.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/widgets/action_button.dart';
import 'package:bankopol/widgets/cards/event_card_widget.dart';
import 'package:bankopol/widgets/investments/investment_list.dart';
import 'package:bankopol/widgets/qr_scanner.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  final Player? playera;

  const PlayerScreen({
    this.playera,
    super.key,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final GameProvider gameProvider = GameProvider();

  late EventCardProvider eventCardProvider;

  @override
  void initState() {
    super.initState();

    eventCardProvider = EventCardProvider(
      gameState: gameProvider.gameState,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Player player = Player(
      id: '1',
      name: 'First Player',
      bankAccount: BankAccount(
        amount: 123,
      ),
      investments: [
        Investment(
          investmentType: InvestmentType.art,
          value: 100,
          quantity: 2,
          interest: 0,
        ),
        Investment(
          investmentType: InvestmentType.collectibles,
          value: 400,
          quantity: 1,
          interest: 4,
        )
      ],
    );

    return ListenableBuilder(
      listenable: gameProvider,
      builder: (context, __) {
        eventCardProvider = EventCardProvider(
          gameState: gameProvider.gameState,
        );

        return Scaffold(
          backgroundColor: Colors.grey,
          body: SafeArea(
            bottom: false,
            child: ColoredBox(
              color: primaryGreen,
              child: Column(
                children: [
                  if (gameProvider.gameState case final data?)
                    for (final player in data.players)
                      Text('Player: ${player.id}'),
                  const QrScannerToggle(),
                  const Expanded(
                    child: InvestmentList(
                      player: player,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: gameProvider.currentEventCard != null
                          ? EventCardWidget(
                              eventCard: gameProvider.currentEventCard!,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  ActionButton(
                    onPressed: () {
                      eventCardProvider.generateCard();
                    },
                    title: 'get card',
                  ),
                  Row(
                    children: [
                      if (gameProvider.currentPlayer == null)
                        InkWell(
                          onTap: () => gameProvider.joinGame(),
                          child: Container(
                            height: 50,
                            color: Colors.white,
                            child: const Text('Join Game'),
                          ),
                        ),
                      InkWell(
                        onTap: () => gameProvider.repository.clearGame(),
                        child: Container(
                          height: 50,
                          color: Colors.white,
                          child: const Text('Clear Game'),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 40))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
