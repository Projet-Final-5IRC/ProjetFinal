// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_seen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MovieSeen _$MovieSeenFromJson(Map<String, dynamic> json) {
  return _MovieSeen.fromJson(json);
}

/// @nodoc
mixin _$MovieSeen {
  int get idSeenMovies => throw _privateConstructorUsedError;
  int get idTmdbMovie => throw _privateConstructorUsedError;
  int get idUser => throw _privateConstructorUsedError;

  /// Serializes this MovieSeen to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovieSeen
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieSeenCopyWith<MovieSeen> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieSeenCopyWith<$Res> {
  factory $MovieSeenCopyWith(MovieSeen value, $Res Function(MovieSeen) then) =
      _$MovieSeenCopyWithImpl<$Res, MovieSeen>;
  @useResult
  $Res call({int idSeenMovies, int idTmdbMovie, int idUser});
}

/// @nodoc
class _$MovieSeenCopyWithImpl<$Res, $Val extends MovieSeen>
    implements $MovieSeenCopyWith<$Res> {
  _$MovieSeenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieSeen
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idSeenMovies = null,
    Object? idTmdbMovie = null,
    Object? idUser = null,
  }) {
    return _then(_value.copyWith(
      idSeenMovies: null == idSeenMovies
          ? _value.idSeenMovies
          : idSeenMovies // ignore: cast_nullable_to_non_nullable
              as int,
      idTmdbMovie: null == idTmdbMovie
          ? _value.idTmdbMovie
          : idTmdbMovie // ignore: cast_nullable_to_non_nullable
              as int,
      idUser: null == idUser
          ? _value.idUser
          : idUser // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieSeenImplCopyWith<$Res>
    implements $MovieSeenCopyWith<$Res> {
  factory _$$MovieSeenImplCopyWith(
          _$MovieSeenImpl value, $Res Function(_$MovieSeenImpl) then) =
      __$$MovieSeenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idSeenMovies, int idTmdbMovie, int idUser});
}

/// @nodoc
class __$$MovieSeenImplCopyWithImpl<$Res>
    extends _$MovieSeenCopyWithImpl<$Res, _$MovieSeenImpl>
    implements _$$MovieSeenImplCopyWith<$Res> {
  __$$MovieSeenImplCopyWithImpl(
      _$MovieSeenImpl _value, $Res Function(_$MovieSeenImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovieSeen
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idSeenMovies = null,
    Object? idTmdbMovie = null,
    Object? idUser = null,
  }) {
    return _then(_$MovieSeenImpl(
      idSeenMovies: null == idSeenMovies
          ? _value.idSeenMovies
          : idSeenMovies // ignore: cast_nullable_to_non_nullable
              as int,
      idTmdbMovie: null == idTmdbMovie
          ? _value.idTmdbMovie
          : idTmdbMovie // ignore: cast_nullable_to_non_nullable
              as int,
      idUser: null == idUser
          ? _value.idUser
          : idUser // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieSeenImpl implements _MovieSeen {
  const _$MovieSeenImpl(
      {required this.idSeenMovies,
      required this.idTmdbMovie,
      required this.idUser});

  factory _$MovieSeenImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieSeenImplFromJson(json);

  @override
  final int idSeenMovies;
  @override
  final int idTmdbMovie;
  @override
  final int idUser;

  @override
  String toString() {
    return 'MovieSeen(idSeenMovies: $idSeenMovies, idTmdbMovie: $idTmdbMovie, idUser: $idUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieSeenImpl &&
            (identical(other.idSeenMovies, idSeenMovies) ||
                other.idSeenMovies == idSeenMovies) &&
            (identical(other.idTmdbMovie, idTmdbMovie) ||
                other.idTmdbMovie == idTmdbMovie) &&
            (identical(other.idUser, idUser) || other.idUser == idUser));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idSeenMovies, idTmdbMovie, idUser);

  /// Create a copy of MovieSeen
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieSeenImplCopyWith<_$MovieSeenImpl> get copyWith =>
      __$$MovieSeenImplCopyWithImpl<_$MovieSeenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieSeenImplToJson(
      this,
    );
  }
}

abstract class _MovieSeen implements MovieSeen {
  const factory _MovieSeen(
      {required final int idSeenMovies,
      required final int idTmdbMovie,
      required final int idUser}) = _$MovieSeenImpl;

  factory _MovieSeen.fromJson(Map<String, dynamic> json) =
      _$MovieSeenImpl.fromJson;

  @override
  int get idSeenMovies;
  @override
  int get idTmdbMovie;
  @override
  int get idUser;

  /// Create a copy of MovieSeen
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieSeenImplCopyWith<_$MovieSeenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
