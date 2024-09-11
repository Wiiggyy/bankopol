import 'package:bankopol/constants/colors.dart';
import 'package:bankopol/models/investment.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/screens/start_screen.dart';
import 'package:bankopol/widgets/action_button.dart';
import 'package:bankopol/widgets/cards/event_card_widget.dart';
import 'package:bankopol/widgets/investments/investment_list.dart';
import 'package:bankopol/widgets/investments/leader_board.dart';
import 'package:bankopol/widgets/qr_scanner.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  final GameProvider gameProvider;

  const PlayerScreen({
    required this.gameProvider,
    super.key,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool shouldDrawCard = false;
  bool didFlip = false;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.gameProvider,
      builder: (context, __) {
        return Scaffold(
          backgroundColor: Colors.grey,
          body: SafeArea(
            bottom: false,
            child: ColoredBox(
              color: primaryGreen,
              child: Column(
                children: [
                  if (widget.gameProvider.currentPlayer case final player?)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Namn: ${player.name}'),
                          Text('Bankkonto: ${player.bankAccount.amount}'),
                        ],
                      ),
                    ),
                  if (widget.gameProvider.gameState case final gameState?)
                    LeaderBoard(gameState: gameState),
                  QrScannerToggle(
                    onCode: (code) {
                      print('------------Scanned code: $code');
                    },
                  ),
                  ActionButton(
                    onPressed: () {
                      widget.gameProvider.saveInvestment(
                        Investment.generateRandomInvestment(),
                      );

                      setState(() {
                        shouldDrawCard = true;
                      });
                    },
                    title: 'Få Investering',
                  ),
                  if (widget.gameProvider.currentPlayer case final player?)
                    Expanded(
                      child: InvestmentList(
                        player: player,
                      ),
                    ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: widget.gameProvider.currentEventCard != null
                          ? EventCardWidget(
                              eventCard: widget.gameProvider.currentEventCard!,
                              onFlip: () {
                                if (didFlip) {
                                  setState(() {
                                    didFlip = false;
                                  });
                                  widget.gameProvider.removeCard();
                                } else {
                                  widget.gameProvider.updatePlayers();
                                  setState(() {
                                    didFlip = true;
                                  });
                                }
                              },
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  if (shouldDrawCard)
                    ActionButton(
                      onPressed: () {
                        widget.gameProvider.generateCard();
                        setState(() {
                          shouldDrawCard = false;
                        });
                      },
                      title: 'dra kort',
                    ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          widget.gameProvider.clearGameState();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StartScreen(
                                gameProvider: widget.gameProvider,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          color: Colors.white,
                          child: const Text('Clear Game'),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
