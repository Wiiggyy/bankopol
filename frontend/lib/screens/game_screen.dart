import 'dart:ui';

import 'package:bankopol/enums/investment_type.dart';
import 'package:bankopol/models/event.dart';
import 'package:bankopol/provider/game/event_provider.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/screens/change_player_name_dialog.dart';
import 'package:bankopol/widgets/bottom_sheets/buy_investment_bottom_sheet.dart';
import 'package:bankopol/widgets/bottom_sheets/sell_investment_bottom_sheet.dart';
import 'package:bankopol/widgets/cards/event_card_widget.dart';
import 'package:bankopol/widgets/investments/investment_list.dart';
import 'package:bankopol/widgets/qr_scanner.dart';
import 'package:bankopol/widgets/score_icon.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameScreen extends StatefulHookConsumerWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<GameScreen> {
  // bool shouldDrawCard = false;

  void showSellInvestmentList() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const SellInvestmentBottomSheet(),
    );
  }

  Future<void> handleScan(String code) async {
    debugPrint('------------Scanned code: $code');

    ref.read(gameStatePodProvider.notifier).fetchInvestment(
          InvestmentType.fromCode(code),
        );
  }

  Future<void> showInvestmentDialog(InvestmentOpportunityEvent event) async {
    await showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BuyInvestmentBottomSheet(
          investment: event.investment,
          onPressedSell: showSellInvestmentList,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentEventCard = ref.watch(currentEventCardProvider);
    ref.listen(
      eventProvider<InvestmentOpportunityEvent>(),
      (_, event) => showInvestmentDialog(event.requireValue),
    );

    final player = ref.watch(
      gameStatePodProvider.select((e) => e.requireValue.player),
    );

    return Scaffold(
      floatingActionButton:
          currentEventCard == null ? QrScanner(onCode: handleScan) : null,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: LeaderIcon(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: InkWell(
                  onTap: () async {
                    final newName = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        return ChangePlayerNameDialog(player: player);
                      },
                    );

                    if (newName != null && newName.isNotEmpty) {
                      ref
                          .read(gameStatePodProvider.notifier)
                          .setPlayerName(newName);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      player.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.wallet),
                  const SizedBox(width: 4),
                  Text(
                    player.bankAccount.amount.toStringAsFixed(0),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
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
            child: CustomScrollView(
              slivers: [
                InvestmentList(
                  key: const ValueKey('PlayerScreen.InvestmentList'),
                  player: player,
                ),
                if (currentEventCard case final currentEventCard?)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: EventCardWidget(
                        eventCard: currentEventCard,
                      ),
                    ),
                  ),
                // if (kDebugMode)
                //   Row(
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           widget.gameProvider.clearGameState();
                //           Navigator.of(context).push(
                //             MaterialPageRoute(
                //               builder: (context) => StartScreen(
                //                 gameProvider: widget.gameProvider,
                //               ),
                //             ),
                //           );
                //         },
                //         child: Container(
                //           height: 50,
                //           color: Colors.white,
                //           child: const Text('Clear Game'),
                //         ),
                //       ),
                //     ],
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
