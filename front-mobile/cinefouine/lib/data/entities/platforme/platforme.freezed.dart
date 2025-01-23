// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'platforme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Platforme _$PlatformeFromJson(Map<String, dynamic> json) {
  return _Platforme.fromJson(json);
}

/// @nodoc
mixin _$Platforme {
  String get providerName => throw _privateConstructorUsedError;
  String get logoPath => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get tmdbLink => throw _privateConstructorUsedError;

  /// Serializes this Platforme to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Platforme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlatformeCopyWith<Platforme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlatformeCopyWith<$Res> {
  factory $PlatformeCopyWith(Platforme value, $Res Function(Platforme) then) =
      _$PlatformeCopyWithImpl<$Res, Platforme>;
  @useResult
  $Res call(
      {String providerName, String logoPath, String type, String tmdbLink});
}

/// @nodoc
class _$PlatformeCopyWithImpl<$Res, $Val extends Platforme>
    implements $PlatformeCopyWith<$Res> {
  _$PlatformeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Platforme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerName = null,
    Object? logoPath = null,
    Object? type = null,
    Object? tmdbLink = null,
  }) {
    return _then(_value.copyWith(
      providerName: null == providerName
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      logoPath: null == logoPath
          ? _value.logoPath
          : logoPath // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      tmdbLink: null == tmdbLink
          ? _value.tmdbLink
          : tmdbLink // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlatformeImplCopyWith<$Res>
    implements $PlatformeCopyWith<$Res> {
  factory _$$PlatformeImplCopyWith(
          _$PlatformeImpl value, $Res Function(_$PlatformeImpl) then) =
      __$$PlatformeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String providerName, String logoPath, String type, String tmdbLink});
}

/// @nodoc
class __$$PlatformeImplCopyWithImpl<$Res>
    extends _$PlatformeCopyWithImpl<$Res, _$PlatformeImpl>
    implements _$$PlatformeImplCopyWith<$Res> {
  __$$PlatformeImplCopyWithImpl(
      _$PlatformeImpl _value, $Res Function(_$PlatformeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Platforme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerName = null,
    Object? logoPath = null,
    Object? type = null,
    Object? tmdbLink = null,
  }) {
    return _then(_$PlatformeImpl(
      providerName: null == providerName
          ? _value.providerName
          : providerName // ignore: cast_nullable_to_non_nullable
              as String,
      logoPath: null == logoPath
          ? _value.logoPath
          : logoPath // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      tmdbLink: null == tmdbLink
          ? _value.tmdbLink
          : tmdbLink // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlatformeImpl implements _Platforme {
  const _$PlatformeImpl(
      {required this.providerName,
      required this.logoPath,
      required this.type,
      required this.tmdbLink});

  factory _$PlatformeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlatformeImplFromJson(json);

  @override
  final String providerName;
  @override
  final String logoPath;
  @override
  final String type;
  @override
  final String tmdbLink;

  @override
  String toString() {
    return 'Platforme(providerName: $providerName, logoPath: $logoPath, type: $type, tmdbLink: $tmdbLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlatformeImpl &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName) &&
            (identical(other.logoPath, logoPath) ||
                other.logoPath == logoPath) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.tmdbLink, tmdbLink) ||
                other.tmdbLink == tmdbLink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, providerName, logoPath, type, tmdbLink);

  /// Create a copy of Platforme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlatformeImplCopyWith<_$PlatformeImpl> get copyWith =>
      __$$PlatformeImplCopyWithImpl<_$PlatformeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlatformeImplToJson(
      this,
    );
  }
}

abstract class _Platforme implements Platforme {
  const factory _Platforme(
      {required final String providerName,
      required final String logoPath,
      required final String type,
      required final String tmdbLink}) = _$PlatformeImpl;

  factory _Platforme.fromJson(Map<String, dynamic> json) =
      _$PlatformeImpl.fromJson;

  @override
  String get providerName;
  @override
  String get logoPath;
  @override
  String get type;
  @override
  String get tmdbLink;

  /// Create a copy of Platforme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlatformeImplCopyWith<_$PlatformeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
