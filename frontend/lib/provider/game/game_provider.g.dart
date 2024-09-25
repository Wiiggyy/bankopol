// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playerIdHash() => r'bf3780c8017aef164f955c5c8ec2649a3d9892f8';

/// See also [playerId].
@ProviderFor(playerId)
final playerIdProvider = AutoDisposeFutureProvider<String>.internal(
  playerId,
  name: r'playerIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playerIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlayerIdRef = AutoDisposeFutureProviderRef<String>;
String _$currentEventCardHash() => r'1f6b568ee7596e44915885efaf4c52d3ce379ad9';

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
String _$gameStatePodHash() => r'48665c0e1184be84091c1021cb80d6cdab552e70';

/// See also [GameStatePod].
@ProviderFor(GameStatePod)
final gameStatePodProvider =
    StreamNotifierProvider<GameStatePod, GameState>.internal(
  GameStatePod.new,
  name: r'gameStatePodProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gameStatePodHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GameStatePod = StreamNotifier<GameState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
