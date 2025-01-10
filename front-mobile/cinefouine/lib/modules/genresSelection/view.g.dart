// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tabBarIndexNotifierHash() =>
    r'5b875bb69d868edd433149f456b7b1225e8f5f1c';

/// See also [TabBarIndexNotifier].
@ProviderFor(TabBarIndexNotifier)
final tabBarIndexNotifierProvider =
    AutoDisposeNotifierProvider<TabBarIndexNotifier, int>.internal(
  TabBarIndexNotifier.new,
  name: r'tabBarIndexNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tabBarIndexNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TabBarIndexNotifier = AutoDisposeNotifier<int>;
String _$genresHash() => r'b82c3dd59a213895f66a2c0e390cf806adf6790c';

/// See also [Genres].
@ProviderFor(Genres)
final genresProvider =
    AutoDisposeAsyncNotifierProvider<Genres, List<Genre>?>.internal(
  Genres.new,
  name: r'genresProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$genresHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Genres = AutoDisposeAsyncNotifier<List<Genre>?>;
String _$selectedGenresHash() => r'937bb5a217d4e3a47ea7432a71f7aa0e6c9a1631';

/// See also [SelectedGenres].
@ProviderFor(SelectedGenres)
final selectedGenresProvider =
    AutoDisposeNotifierProvider<SelectedGenres, Set<int>>.internal(
  SelectedGenres.new,
  name: r'selectedGenresProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedGenresHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedGenres = AutoDisposeNotifier<Set<int>>;
String _$genreColorsHash() => r'09c8a52506fe448536ba81f4427ff797b54a52a0';

/// See also [GenreColors].
@ProviderFor(GenreColors)
final genreColorsProvider =
    AutoDisposeNotifierProvider<GenreColors, Map<int, Color>>.internal(
  GenreColors.new,
  name: r'genreColorsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$genreColorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GenreColors = AutoDisposeNotifier<Map<int, Color>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
