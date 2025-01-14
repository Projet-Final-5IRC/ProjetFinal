// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegisterStatus {
  String get userName => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get dateCreation => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;

  /// Create a copy of RegisterStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterStatusCopyWith<RegisterStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStatusCopyWith<$Res> {
  factory $RegisterStatusCopyWith(
          RegisterStatus value, $Res Function(RegisterStatus) then) =
      _$RegisterStatusCopyWithImpl<$Res, RegisterStatus>;
  @useResult
  $Res call(
      {String userName,
      String firstName,
      String lastName,
      String email,
      String password,
      String dateCreation,
      bool isError});
}

/// @nodoc
class _$RegisterStatusCopyWithImpl<$Res, $Val extends RegisterStatus>
    implements $RegisterStatusCopyWith<$Res> {
  _$RegisterStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? password = null,
    Object? dateCreation = null,
    Object? isError = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreation: null == dateCreation
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as String,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterStatusImplCopyWith<$Res>
    implements $RegisterStatusCopyWith<$Res> {
  factory _$$RegisterStatusImplCopyWith(_$RegisterStatusImpl value,
          $Res Function(_$RegisterStatusImpl) then) =
      __$$RegisterStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userName,
      String firstName,
      String lastName,
      String email,
      String password,
      String dateCreation,
      bool isError});
}

/// @nodoc
class __$$RegisterStatusImplCopyWithImpl<$Res>
    extends _$RegisterStatusCopyWithImpl<$Res, _$RegisterStatusImpl>
    implements _$$RegisterStatusImplCopyWith<$Res> {
  __$$RegisterStatusImplCopyWithImpl(
      _$RegisterStatusImpl _value, $Res Function(_$RegisterStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? password = null,
    Object? dateCreation = null,
    Object? isError = null,
  }) {
    return _then(_$RegisterStatusImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreation: null == dateCreation
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as String,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RegisterStatusImpl implements _RegisterStatus {
  _$RegisterStatusImpl(
      {this.userName = '',
      this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.password = '',
      this.dateCreation = '',
      this.isError = false});

  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final String dateCreation;
  @override
  @JsonKey()
  final bool isError;

  @override
  String toString() {
    return 'RegisterStatus(userName: $userName, firstName: $firstName, lastName: $lastName, email: $email, password: $password, dateCreation: $dateCreation, isError: $isError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterStatusImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.dateCreation, dateCreation) ||
                other.dateCreation == dateCreation) &&
            (identical(other.isError, isError) || other.isError == isError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName, firstName, lastName,
      email, password, dateCreation, isError);

  /// Create a copy of RegisterStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterStatusImplCopyWith<_$RegisterStatusImpl> get copyWith =>
      __$$RegisterStatusImplCopyWithImpl<_$RegisterStatusImpl>(
          this, _$identity);
}

abstract class _RegisterStatus implements RegisterStatus {
  factory _RegisterStatus(
      {final String userName,
      final String firstName,
      final String lastName,
      final String email,
      final String password,
      final String dateCreation,
      final bool isError}) = _$RegisterStatusImpl;

  @override
  String get userName;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get password;
  @override
  String get dateCreation;
  @override
  bool get isError;

  /// Create a copy of RegisterStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterStatusImplCopyWith<_$RegisterStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}