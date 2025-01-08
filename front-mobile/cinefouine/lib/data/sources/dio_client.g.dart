// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioClientHash() => r'1b25ad50ab7ba6b7502625d56513dfa954e9d7db';

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

/// See also [dioClient].
@ProviderFor(dioClient)
const dioClientProvider = DioClientFamily();

/// See also [dioClient].
class DioClientFamily extends Family<DioClient> {
  /// See also [dioClient].
  const DioClientFamily();

  /// See also [dioClient].
  DioClientProvider call({
    required String url,
    Dio? client,
    List<Interceptor>? interceptors,
  }) {
    return DioClientProvider(
      url: url,
      client: client,
      interceptors: interceptors,
    );
  }

  @override
  DioClientProvider getProviderOverride(
    covariant DioClientProvider provider,
  ) {
    return call(
      url: provider.url,
      client: provider.client,
      interceptors: provider.interceptors,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dioClientProvider';
}

/// See also [dioClient].
class DioClientProvider extends Provider<DioClient> {
  /// See also [dioClient].
  DioClientProvider({
    required String url,
    Dio? client,
    List<Interceptor>? interceptors,
  }) : this._internal(
          (ref) => dioClient(
            ref as DioClientRef,
            url: url,
            client: client,
            interceptors: interceptors,
          ),
          from: dioClientProvider,
          name: r'dioClientProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dioClientHash,
          dependencies: DioClientFamily._dependencies,
          allTransitiveDependencies: DioClientFamily._allTransitiveDependencies,
          url: url,
          client: client,
          interceptors: interceptors,
        );

  DioClientProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
    required this.client,
    required this.interceptors,
  }) : super.internal();

  final String url;
  final Dio? client;
  final List<Interceptor>? interceptors;

  @override
  Override overrideWith(
    DioClient Function(DioClientRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DioClientProvider._internal(
        (ref) => create(ref as DioClientRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
        client: client,
        interceptors: interceptors,
      ),
    );
  }

  @override
  ProviderElement<DioClient> createElement() {
    return _DioClientProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DioClientProvider &&
        other.url == url &&
        other.client == client &&
        other.interceptors == interceptors;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);
    hash = _SystemHash.combine(hash, client.hashCode);
    hash = _SystemHash.combine(hash, interceptors.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DioClientRef on ProviderRef<DioClient> {
  /// The parameter `url` of this provider.
  String get url;

  /// The parameter `client` of this provider.
  Dio? get client;

  /// The parameter `interceptors` of this provider.
  List<Interceptor>? get interceptors;
}

class _DioClientProviderElement extends ProviderElement<DioClient>
    with DioClientRef {
  _DioClientProviderElement(super.provider);

  @override
  String get url => (origin as DioClientProvider).url;
  @override
  Dio? get client => (origin as DioClientProvider).client;
  @override
  List<Interceptor>? get interceptors =>
      (origin as DioClientProvider).interceptors;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
