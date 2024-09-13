// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentPlayerHash() => r'8b5492929b8042edda90a4d6fe7790b0770d025e';

/// See also [CurrentPlayer].
@ProviderFor(CurrentPlayer)
final currentPlayerProvider =
    AutoDisposeAsyncNotifierProvider<CurrentPlayer, Player?>.internal(
  CurrentPlayer.new,
  name: r'currentPlayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentPlayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentPlayer = AutoDisposeAsyncNotifier<Player?>;
String _$currentEventCardHash() => r'848f70cfedd46e57af5cd71eb6db9df3d0afce9d';

/// See also [CurrentEventCard].
@ProviderFor(CurrentEventCard)
final currentEventCardProvider =
    AutoDisposeNotifierProvider<CurrentEventCard, EventCard?>.internal(
  CurrentEventCard.new,
  name: r'currentEventCardProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentEventCardHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentEventCard = AutoDisposeNotifier<EventCard?>;
String _$gameStatePodHash() => r'4a01b7aaa2b714f3a4d2fafb8053f4087cf9259b';

/// See also [GameStatePod].
@ProviderFor(GameStatePod)
final gameStatePodProvider =
    AutoDisposeStreamNotifierProvider<GameStatePod, GameState?>.internal(
  GameStatePod.new,
  name: r'gameStatePodProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gameStatePodHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GameStatePod = AutoDisposeStreamNotifier<GameState?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
