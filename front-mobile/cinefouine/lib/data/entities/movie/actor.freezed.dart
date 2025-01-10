// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'actor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Actor _$ActorFromJson(Map<String, dynamic> json) {
  return _Actor.fromJson(json);
}

/// @nodoc
mixin _$Actor {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get character => throw _privateConstructorUsedError;
  String? get profilePath => throw _privateConstructorUsedError;
  double? get popularity => throw _privateConstructorUsedError;

  /// Serializes this Actor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Actor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActorCopyWith<Actor> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActorCopyWith<$Res> {
  factory $ActorCopyWith(Actor value, $Res Function(Actor) then) =
      _$ActorCopyWithImpl<$Res, Actor>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? character,
      String? profilePath,
      double? popularity});
}

/// @nodoc
class _$ActorCopyWithImpl<$Res, $Val extends Actor>
    implements $ActorCopyWith<$Res> {
  _$ActorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Actor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? character = freezed,
    Object? profilePath = freezed,
    Object? popularity = freezed,
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
      character: freezed == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePath: freezed == profilePath
          ? _value.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      popularity: freezed == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActorImplCopyWith<$Res> implements $ActorCopyWith<$Res> {
  factory _$$ActorImplCopyWith(
          _$ActorImpl value, $Res Function(_$ActorImpl) then) =
      __$$ActorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? character,
      String? profilePath,
      double? popularity});
}

/// @nodoc
class __$$ActorImplCopyWithImpl<$Res>
    extends _$ActorCopyWithImpl<$Res, _$ActorImpl>
    implements _$$ActorImplCopyWith<$Res> {
  __$$ActorImplCopyWithImpl(
      _$ActorImpl _value, $Res Function(_$ActorImpl) _then)
      : super(_value, _then);

  /// Create a copy of Actor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? character = freezed,
    Object? profilePath = freezed,
    Object? popularity = freezed,
  }) {
    return _then(_$ActorImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      character: freezed == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePath: freezed == profilePath
          ? _value.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      popularity: freezed == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActorImpl implements _Actor {
  const _$ActorImpl(
      {required this.id,
      required this.name,
      required this.character,
      required this.profilePath,
      required this.popularity});

  factory _$ActorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActorImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? character;
  @override
  final String? profilePath;
  @override
  final double? popularity;

  @override
  String toString() {
    return 'Actor(id: $id, name: $name, character: $character, profilePath: $profilePath, popularity: $popularity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.profilePath, profilePath) ||
                other.profilePath == profilePath) &&
            (identical(other.popularity, popularity) ||
                other.popularity == popularity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, character, profilePath, popularity);

  /// Create a copy of Actor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActorImplCopyWith<_$ActorImpl> get copyWith =>
      __$$ActorImplCopyWithImpl<_$ActorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActorImplToJson(
      this,
    );
  }
}

abstract class _Actor implements Actor {
  const factory _Actor(
      {required final int? id,
      required final String? name,
      required final String? character,
      required final String? profilePath,
      required final double? popularity}) = _$ActorImpl;

  factory _Actor.fromJson(Map<String, dynamic> json) = _$ActorImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get character;
  @override
  String? get profilePath;
  @override
  double? get popularity;

  /// Create a copy of Actor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActorImplCopyWith<_$ActorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
