import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/widgets/bottom_sheets/leader_board_bottom_sheet.dart';
import 'package:flutter/material.dart';

class LeaderIcon extends StatefulWidget {
  final GameProvider gameProvider;
  const LeaderIcon({super.key, required this.gameProvider});

  @override
  State<LeaderIcon> createState() => _LeaderIconState();
}

class _LeaderIconState extends State<LeaderIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  showLeaderboardBottomSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (_) {
        return LeaderBoardBottomSheet(gameProvider: widget.gameProvider);
      },
    );
  }

  List<double> _previousAssetsValues = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    widget.gameProvider.addListener(_onGameStateChange);
    _initializePreviousValues();
  }

  @override
  void dispose() {
    widget.gameProvider.removeListener(_onGameStateChange);
    _controller.dispose();
    super.dispose();
  }

  void _initializePreviousValues() {
    _previousAssetsValues = widget.gameProvider.gameState?.players
            .map((player) => player.totalAssetsValue)
            .toList() ??
        [];
  }

  void _onGameStateChange() {
    final currentAssetsValues = widget.gameProvider.gameState?.players
            .map((player) => player.totalAssetsValue)
            .toList() ??
        [];

    if (_previousAssetsValues.length != currentAssetsValues.length) {
      _previousAssetsValues = currentAssetsValues;
      return;
    }

    for (int i = 0; i < currentAssetsValues.length; i++) {
      if (_previousAssetsValues[i] != currentAssetsValues[i]) {
        _controller.forward(from: 0.0).then((_) => _controller.reverse());
        _previousAssetsValues = currentAssetsValues;
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          return IconButton(
            onPressed: showLeaderboardBottomSheet,
            icon: Icon(
              Icons.emoji_events_rounded,
              color: color,
            ),
          );
        },
      ),
    );
  }
}
