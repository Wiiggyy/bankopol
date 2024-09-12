import 'dart:ui';

import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/screens/start_screen.dart';
import 'package:bankopol/widgets/bottom_sheets/buy_investment_bottom_sheet.dart';
import 'package:bankopol/widgets/bottom_sheets/leader_board_bottom_sheet.dart';
import 'package:bankopol/widgets/bottom_sheets/sell_investment_bottom_sheet.dart';
import 'package:bankopol/widgets/cards/event_card_widget.dart';
import 'package:bankopol/widgets/investments/investment_list.dart';
import 'package:bankopol/widgets/qr_scanner.dart';
import 'package:bankopol/widgets/score_icon.dart';
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
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return SellInvestmentBottomSheet(gameProvider: widget.gameProvider);
      },
    );
  }

  handleScan(String code) async {
    debugPrint('------------Scanned code: $code');

    await showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (_) {
        return BuyInvestmentBottomSheet(
          gameProvider: widget.gameProvider,
          onPressed: () {
            widget.gameProvider.generateCard();
            setState(() {
              shouldDrawCard = true;
            });
            Navigator.of(context).pop();
          },
          onPressedSell: showSellInvestmentList,
          onPressedClose: () {
            widget.gameProvider.generateCard();
            setState(() {
              shouldDrawCard = true;
            });
            Navigator.of(context).pop();
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
        final player = widget.gameProvider.currentPlayer;

        return Scaffold(
          floatingActionButton:
              !shouldDrawCard && widget.gameProvider.currentEventCard == null
                  ? QrScannerToggle(onCode: handleScan)
                  : null,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            LeaderIcon(gameProvider: widget.gameProvider),
                            Text(player?.totalAssetsValue.toStringAsFixed(0) ??
                                '0'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(child: Text(player?.name ?? '')),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.wallet),
                          Text(player?.bankAccount.amount.toStringAsFixed(0) ??
                              '0'),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Image.asset(
                    'assets/background2.webp',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    if (widget.gameProvider.currentPlayer case final player?)
                      Flexible(
                        child: InvestmentList(
                          player: player,
                        ),
                      ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: widget.gameProvider.currentEventCard != null
                            ? EventCardWidget(
                                eventCard:
                                    widget.gameProvider.currentEventCard!,
                                onFlip: () {
                                  if (didFlip) {
                                    setState(() {
                                      didFlip = false;
                                      shouldDrawCard = false;
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
            ],
          ),
        );
      },
    );
  }
}
