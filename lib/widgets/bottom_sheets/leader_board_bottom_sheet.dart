import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/widgets/investments/leader_board.dart';
import 'package:flutter/material.dart';

class LeaderBoardBottomSheet extends StatefulWidget {
  final GameProvider gameProvider;

  const LeaderBoardBottomSheet({
    required this.gameProvider,
    super.key,
  });

  @override
  State<LeaderBoardBottomSheet> createState() => _LeaderBoardBottomSheetState();
}

class _LeaderBoardBottomSheetState extends State<LeaderBoardBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.gameProvider,
      builder: (context, __) {
        print(1111);
        if (widget.gameProvider.gameState case final gameState?) {
          return LeaderBoard(gameState: gameState);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
