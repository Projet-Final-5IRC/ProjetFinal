// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'film_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FilmInfo _$FilmInfoFromJson(Map<String, dynamic> json) {
  return _FilmInfo.fromJson(json);
}

/// @nodoc
mixin _$FilmInfo {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  /// Serializes this FilmInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FilmInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilmInfoCopyWith<FilmInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilmInfoCopyWith<$Res> {
  factory $FilmInfoCopyWith(FilmInfo value, $Res Function(FilmInfo) then) =
      _$FilmInfoCopyWithImpl<$Res, FilmInfo>;
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class _$FilmInfoCopyWithImpl<$Res, $Val extends FilmInfo>
    implements $FilmInfoCopyWith<$Res> {
  _$FilmInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilmInfo
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
abstract class _$$FilmInfoImplCopyWith<$Res>
    implements $FilmInfoCopyWith<$Res> {
  factory _$$FilmInfoImplCopyWith(
          _$FilmInfoImpl value, $Res Function(_$FilmInfoImpl) then) =
      __$$FilmInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class __$$FilmInfoImplCopyWithImpl<$Res>
    extends _$FilmInfoCopyWithImpl<$Res, _$FilmInfoImpl>
    implements _$$FilmInfoImplCopyWith<$Res> {
  __$$FilmInfoImplCopyWithImpl(
      _$FilmInfoImpl _value, $Res Function(_$FilmInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilmInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$FilmInfoImpl(
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
class _$FilmInfoImpl implements _FilmInfo {
  const _$FilmInfoImpl({required this.id, required this.title});

  factory _$FilmInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilmInfoImplFromJson(json);

  @override
  final int id;
  @override
  final String title;

  @override
  String toString() {
    return 'FilmInfo(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilmInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  /// Create a copy of FilmInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilmInfoImplCopyWith<_$FilmInfoImpl> get copyWith =>
      __$$FilmInfoImplCopyWithImpl<_$FilmInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilmInfoImplToJson(
      this,
    );
  }
}

abstract class _FilmInfo implements FilmInfo {
  const factory _FilmInfo(
      {required final int id, required final String title}) = _$FilmInfoImpl;

  factory _FilmInfo.fromJson(Map<String, dynamic> json) =
      _$FilmInfoImpl.fromJson;

  @override
  int get id;
  @override
  String get title;

  /// Create a copy of FilmInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilmInfoImplCopyWith<_$FilmInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
