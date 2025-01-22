// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_liked.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MovieLiked _$MovieLikedFromJson(Map<String, dynamic> json) {
  return _MovieLiked.fromJson(json);
}

/// @nodoc
mixin _$MovieLiked {
  int get idLikedMovies => throw _privateConstructorUsedError;
  int get idTmdbMovie => throw _privateConstructorUsedError;
  int get idUser => throw _privateConstructorUsedError;

  /// Serializes this MovieLiked to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovieLiked
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieLikedCopyWith<MovieLiked> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieLikedCopyWith<$Res> {
  factory $MovieLikedCopyWith(
          MovieLiked value, $Res Function(MovieLiked) then) =
      _$MovieLikedCopyWithImpl<$Res, MovieLiked>;
  @useResult
  $Res call({int idLikedMovies, int idTmdbMovie, int idUser});
}

/// @nodoc
class _$MovieLikedCopyWithImpl<$Res, $Val extends MovieLiked>
    implements $MovieLikedCopyWith<$Res> {
  _$MovieLikedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieLiked
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idLikedMovies = null,
    Object? idTmdbMovie = null,
    Object? idUser = null,
  }) {
    return _then(_value.copyWith(
      idLikedMovies: null == idLikedMovies
          ? _value.idLikedMovies
          : idLikedMovies // ignore: cast_nullable_to_non_nullable
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
abstract class _$$MovieLikedImplCopyWith<$Res>
    implements $MovieLikedCopyWith<$Res> {
  factory _$$MovieLikedImplCopyWith(
          _$MovieLikedImpl value, $Res Function(_$MovieLikedImpl) then) =
      __$$MovieLikedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idLikedMovies, int idTmdbMovie, int idUser});
}

/// @nodoc
class __$$MovieLikedImplCopyWithImpl<$Res>
    extends _$MovieLikedCopyWithImpl<$Res, _$MovieLikedImpl>
    implements _$$MovieLikedImplCopyWith<$Res> {
  __$$MovieLikedImplCopyWithImpl(
      _$MovieLikedImpl _value, $Res Function(_$MovieLikedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovieLiked
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idLikedMovies = null,
    Object? idTmdbMovie = null,
    Object? idUser = null,
  }) {
    return _then(_$MovieLikedImpl(
      idLikedMovies: null == idLikedMovies
          ? _value.idLikedMovies
          : idLikedMovies // ignore: cast_nullable_to_non_nullable
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
class _$MovieLikedImpl implements _MovieLiked {
  const _$MovieLikedImpl(
      {required this.idLikedMovies,
      required this.idTmdbMovie,
      required this.idUser});

  factory _$MovieLikedImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieLikedImplFromJson(json);

  @override
  final int idLikedMovies;
  @override
  final int idTmdbMovie;
  @override
  final int idUser;

  @override
  String toString() {
    return 'MovieLiked(idLikedMovies: $idLikedMovies, idTmdbMovie: $idTmdbMovie, idUser: $idUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieLikedImpl &&
            (identical(other.idLikedMovies, idLikedMovies) ||
                other.idLikedMovies == idLikedMovies) &&
            (identical(other.idTmdbMovie, idTmdbMovie) ||
                other.idTmdbMovie == idTmdbMovie) &&
            (identical(other.idUser, idUser) || other.idUser == idUser));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idLikedMovies, idTmdbMovie, idUser);

  /// Create a copy of MovieLiked
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieLikedImplCopyWith<_$MovieLikedImpl> get copyWith =>
      __$$MovieLikedImplCopyWithImpl<_$MovieLikedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieLikedImplToJson(
      this,
    );
  }
}

abstract class _MovieLiked implements MovieLiked {
  const factory _MovieLiked(
      {required final int idLikedMovies,
      required final int idTmdbMovie,
      required final int idUser}) = _$MovieLikedImpl;

  factory _MovieLiked.fromJson(Map<String, dynamic> json) =
      _$MovieLikedImpl.fromJson;

  @override
  int get idLikedMovies;
  @override
  int get idTmdbMovie;
  @override
  int get idUser;

  /// Create a copy of MovieLiked
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieLikedImplCopyWith<_$MovieLikedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
