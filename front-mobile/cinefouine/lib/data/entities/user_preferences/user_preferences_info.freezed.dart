// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preferences_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserPreference _$UserPreferenceFromJson(Map<String, dynamic> json) {
  return _UserPreference.fromJson(json);
}

/// @nodoc
mixin _$UserPreference {
  int get idGenre => throw _privateConstructorUsedError;
  int get idPreference => throw _privateConstructorUsedError;
  int get idUser => throw _privateConstructorUsedError;

  /// Serializes this UserPreference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPreference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPreferenceCopyWith<UserPreference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPreferenceCopyWith<$Res> {
  factory $UserPreferenceCopyWith(
          UserPreference value, $Res Function(UserPreference) then) =
      _$UserPreferenceCopyWithImpl<$Res, UserPreference>;
  @useResult
  $Res call({int idGenre, int idPreference, int idUser});
}

/// @nodoc
class _$UserPreferenceCopyWithImpl<$Res, $Val extends UserPreference>
    implements $UserPreferenceCopyWith<$Res> {
  _$UserPreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPreference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idGenre = null,
    Object? idPreference = null,
    Object? idUser = null,
  }) {
    return _then(_value.copyWith(
      idGenre: null == idGenre
          ? _value.idGenre
          : idGenre // ignore: cast_nullable_to_non_nullable
              as int,
      idPreference: null == idPreference
          ? _value.idPreference
          : idPreference // ignore: cast_nullable_to_non_nullable
              as int,
      idUser: null == idUser
          ? _value.idUser
          : idUser // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPreferenceImplCopyWith<$Res>
    implements $UserPreferenceCopyWith<$Res> {
  factory _$$UserPreferenceImplCopyWith(_$UserPreferenceImpl value,
          $Res Function(_$UserPreferenceImpl) then) =
      __$$UserPreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idGenre, int idPreference, int idUser});
}

/// @nodoc
class __$$UserPreferenceImplCopyWithImpl<$Res>
    extends _$UserPreferenceCopyWithImpl<$Res, _$UserPreferenceImpl>
    implements _$$UserPreferenceImplCopyWith<$Res> {
  __$$UserPreferenceImplCopyWithImpl(
      _$UserPreferenceImpl _value, $Res Function(_$UserPreferenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPreference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idGenre = null,
    Object? idPreference = null,
    Object? idUser = null,
  }) {
    return _then(_$UserPreferenceImpl(
      idGenre: null == idGenre
          ? _value.idGenre
          : idGenre // ignore: cast_nullable_to_non_nullable
              as int,
      idPreference: null == idPreference
          ? _value.idPreference
          : idPreference // ignore: cast_nullable_to_non_nullable
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
class _$UserPreferenceImpl implements _UserPreference {
  const _$UserPreferenceImpl(
      {required this.idGenre,
      required this.idPreference,
      required this.idUser});

  factory _$UserPreferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPreferenceImplFromJson(json);

  @override
  final int idGenre;
  @override
  final int idPreference;
  @override
  final int idUser;

  @override
  String toString() {
    return 'UserPreference(idGenre: $idGenre, idPreference: $idPreference, idUser: $idUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPreferenceImpl &&
            (identical(other.idGenre, idGenre) || other.idGenre == idGenre) &&
            (identical(other.idPreference, idPreference) ||
                other.idPreference == idPreference) &&
            (identical(other.idUser, idUser) || other.idUser == idUser));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, idGenre, idPreference, idUser);

  /// Create a copy of UserPreference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPreferenceImplCopyWith<_$UserPreferenceImpl> get copyWith =>
      __$$UserPreferenceImplCopyWithImpl<_$UserPreferenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPreferenceImplToJson(
      this,
    );
  }
}

abstract class _UserPreference implements UserPreference {
  const factory _UserPreference(
      {required final int idGenre,
      required final int idPreference,
      required final int idUser}) = _$UserPreferenceImpl;

  factory _UserPreference.fromJson(Map<String, dynamic> json) =
      _$UserPreferenceImpl.fromJson;

  @override
  int get idGenre;
  @override
  int get idPreference;
  @override
  int get idUser;

  /// Create a copy of UserPreference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPreferenceImplCopyWith<_$UserPreferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
