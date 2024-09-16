// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentPlayerHash() => r'95522b205a17e12050194d489948554146c713b7';

/// See also [CurrentPlayer].
@ProviderFor(CurrentPlayer)
final currentPlayerProvider =
    AsyncNotifierProvider<CurrentPlayer, Player?>.internal(
  CurrentPlayer.new,
  name: r'currentPlayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentPlayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentPlayer = AsyncNotifier<Player?>;
String _$currentEventCardHash() => r'492351e4308a9fee25530b916526a04f39631f7a';

/// See also [CurrentEventCard].
@ProviderFor(CurrentEventCard)
final currentEventCardProvider =
    NotifierProvider<CurrentEventCard, EventCard?>.internal(
  CurrentEventCard.new,
  name: r'currentEventCardProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentEventCardHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentEventCard = Notifier<EventCard?>;
String _$gameStatePodHash() => r'b56c51889835a08dc7b8a7c1037acf74ad492e9a';

/// See also [GameStatePod].
@ProviderFor(GameStatePod)
final gameStatePodProvider =
    StreamNotifierProvider<GameStatePod, GameState?>.internal(
  GameStatePod.new,
  name: r'gameStatePodProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gameStatePodHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GameStatePod = StreamNotifier<GameState?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
