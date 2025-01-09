// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MovieInfo _$MovieInfoFromJson(Map<String, dynamic> json) {
  return _MovieInfo.fromJson(json);
}

/// @nodoc
mixin _$MovieInfo {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  /// Serializes this MovieInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovieInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieInfoCopyWith<MovieInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieInfoCopyWith<$Res> {
  factory $MovieInfoCopyWith(MovieInfo value, $Res Function(MovieInfo) then) =
      _$MovieInfoCopyWithImpl<$Res, MovieInfo>;
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class _$MovieInfoCopyWithImpl<$Res, $Val extends MovieInfo>
    implements $MovieInfoCopyWith<$Res> {
  _$MovieInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieInfoImplCopyWith<$Res>
    implements $MovieInfoCopyWith<$Res> {
  factory _$$MovieInfoImplCopyWith(
          _$MovieInfoImpl value, $Res Function(_$MovieInfoImpl) then) =
      __$$MovieInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class __$$MovieInfoImplCopyWithImpl<$Res>
    extends _$MovieInfoCopyWithImpl<$Res, _$MovieInfoImpl>
    implements _$$MovieInfoImplCopyWith<$Res> {
  __$$MovieInfoImplCopyWithImpl(
      _$MovieInfoImpl _value, $Res Function(_$MovieInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovieInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$MovieInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieInfoImpl implements _MovieInfo {
  const _$MovieInfoImpl({required this.id, required this.title});

  factory _$MovieInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieInfoImplFromJson(json);

  @override
  final int id;
  @override
  final String title;

  @override
  String toString() {
    return 'MovieInfo(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  /// Create a copy of MovieInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieInfoImplCopyWith<_$MovieInfoImpl> get copyWith =>
      __$$MovieInfoImplCopyWithImpl<_$MovieInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieInfoImplToJson(
      this,
    );
  }
}

abstract class _MovieInfo implements MovieInfo {
  const factory _MovieInfo(
      {required final int id, required final String title}) = _$MovieInfoImpl;

  factory _MovieInfo.fromJson(Map<String, dynamic> json) =
      _$MovieInfoImpl.fromJson;

  @override
  int get id;
  @override
  String get title;

  /// Create a copy of MovieInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieInfoImplCopyWith<_$MovieInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
