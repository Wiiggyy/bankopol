// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventHash() => r'e6fcec321cbb0d04d79dccc44651060f091343a1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [event].
@ProviderFor(event)
const eventProvider = EventFamily();

/// See also [event].
class EventFamily extends Family {
  /// See also [event].
  const EventFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'eventProvider';

  /// See also [event].
  EventProvider<E> call<E extends Event>() {
    return EventProvider<E>();
  }

  @visibleForOverriding
  @override
  EventProvider<Event> getProviderOverride(
    covariant EventProvider<Event> provider,
  ) {
    return call();
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      Stream<E> Function<E extends Event>(EventRef ref) create) {
    return _$EventFamilyOverride(this, create);
  }
}

class _$EventFamilyOverride implements FamilyOverride {
  _$EventFamilyOverride(this.overriddenFamily, this.create);

  final Stream<E> Function<E extends Event>(EventRef ref) create;

  @override
  final EventFamily overriddenFamily;

  @override
  EventProvider getProviderOverride(
    covariant EventProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [event].
class EventProvider<E extends Event> extends AutoDisposeStreamProvider<E> {
  /// See also [event].
  EventProvider()
      : this._internal(
          (ref) => event<E>(
            ref as EventRef<E>,
          ),
          from: eventProvider,
          name: r'eventProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventHash,
          dependencies: EventFamily._dependencies,
          allTransitiveDependencies: EventFamily._allTransitiveDependencies,
        );

  EventProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
  }) : super.internal();

  @override
  Override overrideWith(
    Stream<E> Function(EventRef<E> ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventProvider<E>._internal(
        (ref) => create(ref as EventRef<E>),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
      ),
    );
  }

  @override
  () get argument {
    return ();
  }

  @override
  AutoDisposeStreamProviderElement<E> createElement() {
    return _EventProviderElement(this);
  }

  EventProvider _copyWith(
    Stream<E> Function<E extends Event>(EventRef ref) create,
  ) {
    return EventProvider._internal(
      (ref) => create(ref as EventRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EventProvider && other.runtimeType == runtimeType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, E.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EventRef<E extends Event> on AutoDisposeStreamProviderRef<E> {}

class _EventProviderElement<E extends Event>
    extends AutoDisposeStreamProviderElement<E> with EventRef<E> {
  _EventProviderElement(super.provider);
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
