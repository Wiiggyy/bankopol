import 'package:bankopol/provider/game/game_provider.dart';
import 'package:bankopol/screens/create_player_screen.dart';
import 'package:bankopol/screens/loading_screen.dart';
import 'package:bankopol/screens/player_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlayer = ref.watch(
      currentPlayerProvider.select((e) => e.whenData((e) => e != null)),
    );

    return switch (hasPlayer) {
      AsyncLoading() => const LoadingScreen(),
      AsyncData(value: true) => const PlayerScreen(),
      AsyncData(value: false) => const CreatePlayer(),
      AsyncError(:final error) => throw error,
    };
  }
}
