// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$genresHash() => r'1a2edb13dacd04dee18d4b9cac79d268883fac43';

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
String _$userGenresHash() => r'a9c05845ebc1b1da9bcd9640fed6cf71556bcd44';

/// See also [UserGenres].
@ProviderFor(UserGenres)
final userGenresProvider = AutoDisposeAsyncNotifierProvider<UserGenres,
    List<UserPreference>?>.internal(
  UserGenres.new,
  name: r'userGenresProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userGenresHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserGenres = AutoDisposeAsyncNotifier<List<UserPreference>?>;
String _$selectedGenresHash() => r'7498b1f4067fbd6a5bca7fa51f0fbda58ca06235';

/// See also [SelectedGenres].
@ProviderFor(SelectedGenres)
final selectedGenresProvider =
    AutoDisposeNotifierProvider<SelectedGenres, List<int>>.internal(
  SelectedGenres.new,
  name: r'selectedGenresProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedGenresHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedGenres = AutoDisposeNotifier<List<int>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
