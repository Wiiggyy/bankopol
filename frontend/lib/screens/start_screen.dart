import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/screens/game_screen.dart';
import 'package:bankopol/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasGameState = ref.watch(
      gameStatePodProvider.select((e) => e.whenData((e) => true)),
    );

    return switch (hasGameState) {
      AsyncLoading() => const LoadingScreen(),
      AsyncData() => const GameScreen(),
      AsyncError() => const Material(child: Center(child: Text('error'))),
    };
  }
}
