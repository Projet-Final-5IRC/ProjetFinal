// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_info_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MovieInfoDetail _$MovieInfoDetailFromJson(Map<String, dynamic> json) {
  return _MovieInfoDetail.fromJson(json);
}

/// @nodoc
mixin _$MovieInfoDetail {
  Details? get details => throw _privateConstructorUsedError;
  List<Actor>? get actors => throw _privateConstructorUsedError;

  /// Serializes this MovieInfoDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovieInfoDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieInfoDetailCopyWith<MovieInfoDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieInfoDetailCopyWith<$Res> {
  factory $MovieInfoDetailCopyWith(
          MovieInfoDetail value, $Res Function(MovieInfoDetail) then) =
      _$MovieInfoDetailCopyWithImpl<$Res, MovieInfoDetail>;
  @useResult
  $Res call({Details? details, List<Actor>? actors});

  $DetailsCopyWith<$Res>? get details;
}

/// @nodoc
class _$MovieInfoDetailCopyWithImpl<$Res, $Val extends MovieInfoDetail>
    implements $MovieInfoDetailCopyWith<$Res> {
  _$MovieInfoDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieInfoDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? details = freezed,
    Object? actors = freezed,
  }) {
    return _then(_value.copyWith(
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as Details?,
      actors: freezed == actors
          ? _value.actors
          : actors // ignore: cast_nullable_to_non_nullable
              as List<Actor>?,
    ) as $Val);
  }

  /// Create a copy of MovieInfoDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DetailsCopyWith<$Res>? get details {
    if (_value.details == null) {
      return null;
    }

    return $DetailsCopyWith<$Res>(_value.details!, (value) {
      return _then(_value.copyWith(details: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MovieInfoDetailImplCopyWith<$Res>
    implements $MovieInfoDetailCopyWith<$Res> {
  factory _$$MovieInfoDetailImplCopyWith(_$MovieInfoDetailImpl value,
          $Res Function(_$MovieInfoDetailImpl) then) =
      __$$MovieInfoDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Details? details, List<Actor>? actors});

  @override
  $DetailsCopyWith<$Res>? get details;
}

/// @nodoc
class __$$MovieInfoDetailImplCopyWithImpl<$Res>
    extends _$MovieInfoDetailCopyWithImpl<$Res, _$MovieInfoDetailImpl>
    implements _$$MovieInfoDetailImplCopyWith<$Res> {
  __$$MovieInfoDetailImplCopyWithImpl(
      _$MovieInfoDetailImpl _value, $Res Function(_$MovieInfoDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovieInfoDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? details = freezed,
    Object? actors = freezed,
  }) {
    return _then(_$MovieInfoDetailImpl(
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as Details?,
      actors: freezed == actors
          ? _value._actors
          : actors // ignore: cast_nullable_to_non_nullable
              as List<Actor>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieInfoDetailImpl implements _MovieInfoDetail {
  const _$MovieInfoDetailImpl(
      {required this.details, required final List<Actor>? actors})
      : _actors = actors;

  factory _$MovieInfoDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieInfoDetailImplFromJson(json);

  @override
  final Details? details;
  final List<Actor>? _actors;
  @override
  List<Actor>? get actors {
    final value = _actors;
    if (value == null) return null;
    if (_actors is EqualUnmodifiableListView) return _actors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MovieInfoDetail(details: $details, actors: $actors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieInfoDetailImpl &&
            (identical(other.details, details) || other.details == details) &&
            const DeepCollectionEquality().equals(other._actors, _actors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, details, const DeepCollectionEquality().hash(_actors));

  /// Create a copy of MovieInfoDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieInfoDetailImplCopyWith<_$MovieInfoDetailImpl> get copyWith =>
      __$$MovieInfoDetailImplCopyWithImpl<_$MovieInfoDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieInfoDetailImplToJson(
      this,
    );
  }
}

abstract class _MovieInfoDetail implements MovieInfoDetail {
  const factory _MovieInfoDetail(
      {required final Details? details,
      required final List<Actor>? actors}) = _$MovieInfoDetailImpl;

  factory _MovieInfoDetail.fromJson(Map<String, dynamic> json) =
      _$MovieInfoDetailImpl.fromJson;

  @override
  Details? get details;
  @override
  List<Actor>? get actors;

  /// Create a copy of MovieInfoDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieInfoDetailImplCopyWith<_$MovieInfoDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Details _$DetailsFromJson(Map<String, dynamic> json) {
  return _Details.fromJson(json);
}

/// @nodoc
mixin _$Details {
  String? get title => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_path')
  String? get posterPath => throw _privateConstructorUsedError;
  int? get runtime => throw _privateConstructorUsedError;
  @JsonKey(name: 'release_date')
  DateTime? get releaseDate => throw _privateConstructorUsedError;
  List<Genre>? get genres => throw _privateConstructorUsedError;

  /// Serializes this Details to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Details
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetailsCopyWith<Details> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailsCopyWith<$Res> {
  factory $DetailsCopyWith(Details value, $Res Function(Details) then) =
      _$DetailsCopyWithImpl<$Res, Details>;
  @useResult
  $Res call(
      {String? title,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      int? runtime,
      @JsonKey(name: 'release_date') DateTime? releaseDate,
      List<Genre>? genres});
}

/// @nodoc
class _$DetailsCopyWithImpl<$Res, $Val extends Details>
    implements $DetailsCopyWith<$Res> {
  _$DetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Details
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? runtime = freezed,
    Object? releaseDate = freezed,
    Object? genres = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      runtime: freezed == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      genres: freezed == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DetailsImplCopyWith<$Res> implements $DetailsCopyWith<$Res> {
  factory _$$DetailsImplCopyWith(
          _$DetailsImpl value, $Res Function(_$DetailsImpl) then) =
      __$$DetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      int? runtime,
      @JsonKey(name: 'release_date') DateTime? releaseDate,
      List<Genre>? genres});
}

/// @nodoc
class __$$DetailsImplCopyWithImpl<$Res>
    extends _$DetailsCopyWithImpl<$Res, _$DetailsImpl>
    implements _$$DetailsImplCopyWith<$Res> {
  __$$DetailsImplCopyWithImpl(
      _$DetailsImpl _value, $Res Function(_$DetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Details
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? runtime = freezed,
    Object? releaseDate = freezed,
    Object? genres = freezed,
  }) {
    return _then(_$DetailsImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      runtime: freezed == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      genres: freezed == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DetailsImpl implements _Details {
  const _$DetailsImpl(
      {required this.title,
      required this.overview,
      @JsonKey(name: 'poster_path') required this.posterPath,
      required this.runtime,
      @JsonKey(name: 'release_date') required this.releaseDate,
      required final List<Genre>? genres})
      : _genres = genres;

  factory _$DetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetailsImplFromJson(json);

  @override
  final String? title;
  @override
  final String? overview;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  final int? runtime;
  @override
  @JsonKey(name: 'release_date')
  final DateTime? releaseDate;
  final List<Genre>? _genres;
  @override
  List<Genre>? get genres {
    final value = _genres;
    if (value == null) return null;
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Details(title: $title, overview: $overview, posterPath: $posterPath, runtime: $runtime, releaseDate: $releaseDate, genres: $genres)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailsImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            const DeepCollectionEquality().equals(other._genres, _genres));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, overview, posterPath,
      runtime, releaseDate, const DeepCollectionEquality().hash(_genres));

  /// Create a copy of Details
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailsImplCopyWith<_$DetailsImpl> get copyWith =>
      __$$DetailsImplCopyWithImpl<_$DetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetailsImplToJson(
      this,
    );
  }
}

abstract class _Details implements Details {
  const factory _Details(
      {required final String? title,
      required final String? overview,
      @JsonKey(name: 'poster_path') required final String? posterPath,
      required final int? runtime,
      @JsonKey(name: 'release_date') required final DateTime? releaseDate,
      required final List<Genre>? genres}) = _$DetailsImpl;

  factory _Details.fromJson(Map<String, dynamic> json) = _$DetailsImpl.fromJson;

  @override
  String? get title;
  @override
  String? get overview;
  @override
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @override
  int? get runtime;
  @override
  @JsonKey(name: 'release_date')
  DateTime? get releaseDate;
  @override
  List<Genre>? get genres;

  /// Create a copy of Details
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetailsImplCopyWith<_$DetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Genre _$GenreFromJson(Map<String, dynamic> json) {
  return _Genre.fromJson(json);
}

/// @nodoc
mixin _$Genre {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this Genre to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Genre
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GenreCopyWith<Genre> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenreCopyWith<$Res> {
  factory $GenreCopyWith(Genre value, $Res Function(Genre) then) =
      _$GenreCopyWithImpl<$Res, Genre>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$GenreCopyWithImpl<$Res, $Val extends Genre>
    implements $GenreCopyWith<$Res> {
  _$GenreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Genre
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenreImplCopyWith<$Res> implements $GenreCopyWith<$Res> {
  factory _$$GenreImplCopyWith(
          _$GenreImpl value, $Res Function(_$GenreImpl) then) =
      __$$GenreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$GenreImplCopyWithImpl<$Res>
    extends _$GenreCopyWithImpl<$Res, _$GenreImpl>
    implements _$$GenreImplCopyWith<$Res> {
  __$$GenreImplCopyWithImpl(
      _$GenreImpl _value, $Res Function(_$GenreImpl) _then)
      : super(_value, _then);

  /// Create a copy of Genre
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$GenreImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenreImpl implements _Genre {
  const _$GenreImpl({required this.id, required this.name});

  factory _$GenreImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenreImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'Genre(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of Genre
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenreImplCopyWith<_$GenreImpl> get copyWith =>
      __$$GenreImplCopyWithImpl<_$GenreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GenreImplToJson(
      this,
    );
  }
}

abstract class _Genre implements Genre {
  const factory _Genre({required final int? id, required final String? name}) =
      _$GenreImpl;

  factory _Genre.fromJson(Map<String, dynamic> json) = _$GenreImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of Genre
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenreImplCopyWith<_$GenreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
