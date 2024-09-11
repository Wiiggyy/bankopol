import 'package:bankopol/constants/colors.dart';
import 'package:bankopol/models/investment.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/screens/start_screen.dart';
import 'package:bankopol/widgets/action_button.dart';
import 'package:bankopol/widgets/cards/event_card_widget.dart';
import 'package:bankopol/widgets/investments/investment_card.dart';
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

  showSellInvestmentList() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: ListenableBuilder(
            listenable: widget.gameProvider,
            builder: (context, __) {
              return Column(
                children: [
                  for (final investment
                      in widget.gameProvider.currentPlayer?.investments ??
                          <Investment>{})
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Dismissible(
                        key: ObjectKey(investment),
                        onDismissed: (direction) {
                          widget.gameProvider.sellInvestment(investment);
                          Navigator.of(context).pop();
                        },
                        background: Container(
                          color: Colors.red.shade500,
                          child: const Icon(Icons.delete),
                        ),
                        child: InvestmentCard(
                            key: ObjectKey(investment), investment: investment),
                      ),
                    )
                ],
              );
            },
          ),
        );
      },
    );
  }

  handleScan(String code) async {
    print('------------Scanned code: $code');
    final randomInvestment = Investment.generateRandomInvestment();

    final canBuy =
        (widget.gameProvider.currentPlayer?.bankAccount.amount ?? 0) >=
            randomInvestment.value;
    await showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ListenableBuilder(
          listenable: widget.gameProvider,
          builder: (context, __) {
            return Container(
              color: Colors.white60,
              height: 500,
              width: double.infinity,
              child: Column(
                children: [
                  Text('Scanned code: $code'),
                  InvestmentCard(investment: randomInvestment),
                  if (!canBuy)
                    ActionButton(
                      onPressed: showSellInvestmentList,
                      title: 'Sälj investeringar',
                    ),
                  if (!shouldDrawCard && canBuy)
                    ActionButton(
                      onPressed: () {
                        widget.gameProvider.buyInvestment(randomInvestment);
                        setState(() {
                          shouldDrawCard = true;
                        });
                        Navigator.of(context).pop();
                      },
                      title: 'Köp',
                    ),
                  ActionButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    title: 'Köp inte',
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

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
                          Text(
                              'Bankkonto: ${player.bankAccount.amount.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  if (widget.gameProvider.gameState case final gameState?)
                    LeaderBoard(gameState: gameState),
                  if (!shouldDrawCard &&
                      widget.gameProvider.currentEventCard == null)
                    QrScannerToggle(onCode: handleScan),
                  // ActionButton(
                  //   onPressed: () {
                  //     widget.gameProvider.buyInvestment(
                  //       Investment.generateRandomInvestment(),
                  //     );

                  //     setState(() {
                  //       shouldDrawCard = true;
                  //     });
                  //   },
                  //   title: 'Få Investering',
                  // ),
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
