import 'package:bankopol/models/game_state.dart';
import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/widgets/investments/leader_board.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LeaderIcon extends ConsumerStatefulWidget {
  const LeaderIcon({super.key});

  @override
  ConsumerState<LeaderIcon> createState() => _LeaderIconState();
}

class _LeaderIconState extends ConsumerState<LeaderIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void showLeaderboardBottomSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (_) {
        return const LeaderBoard();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    ref.listenManual(
      gameStatePodProvider,
      (oldState, newState) {
        _onGameStateChange(newState.requireValue);
      },
    );

    _initializePreviousValues(ref.read(gameStatePodProvider).requireValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializePreviousValues(GameState gameState) {
    // _previousAssetsValues =
    //     gameState.players.map((player) => player.totalAssetsValue).toList();
  }

  void _onGameStateChange(GameState gameState) {
    // final currentAssetsValues =
    //     gameState.players.map((player) => player.totalAssetsValue).toList();
    //
    // if (_previousAssetsValues.length != currentAssetsValues.length) {
    //   _previousAssetsValues = currentAssetsValues;
    //   return;
    // }
    //
    // for (var i = 0; i < currentAssetsValues.length; i++) {
    //   if (_previousAssetsValues[i] != currentAssetsValues[i]) {
    //     _controller.forward(from: 0.0).then((_) => _controller.reverse());
    //     _previousAssetsValues = currentAssetsValues;
    //     return;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(
      gameStatePodProvider.select((e) => e.requireValue.player),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            -10 * (0.5 - (_controller.value - 0.5).abs()), // Move up
          ),
          child: child,
        );
      },
      child: TweenAnimationBuilder<Color?>(
        tween: ColorTween(
          begin: Colors.black,
          end: Colors.black,
        ),
        duration: const Duration(milliseconds: 500),
        builder: (context, color, child) {
          return InkWell(
            onTap: showLeaderboardBottomSheet,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_events_rounded,
                    color: color,
                  ),
                  Text(
                    player.totalAssetsValue.toStringAsFixed(0),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
