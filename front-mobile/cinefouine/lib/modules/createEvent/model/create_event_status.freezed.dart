// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_event_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateEventStatus {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get hours => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;

  /// Create a copy of CreateEventStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateEventStatusCopyWith<CreateEventStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateEventStatusCopyWith<$Res> {
  factory $CreateEventStatusCopyWith(
          CreateEventStatus value, $Res Function(CreateEventStatus) then) =
      _$CreateEventStatusCopyWithImpl<$Res, CreateEventStatus>;
  @useResult
  $Res call(
      {String title,
      String description,
      String date,
      String hours,
      String location,
      bool isError});
}

/// @nodoc
class _$CreateEventStatusCopyWithImpl<$Res, $Val extends CreateEventStatus>
    implements $CreateEventStatusCopyWith<$Res> {
  _$CreateEventStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateEventStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? date = null,
    Object? hours = null,
    Object? location = null,
    Object? isError = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
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
    implements $CreateEventStatusCopyWith<$Res> {
  factory _$$RegisterStatusImplCopyWith(_$RegisterStatusImpl value,
          $Res Function(_$RegisterStatusImpl) then) =
      __$$RegisterStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      String date,
      String hours,
      String location,
      bool isError});
}

/// @nodoc
class __$$RegisterStatusImplCopyWithImpl<$Res>
    extends _$CreateEventStatusCopyWithImpl<$Res, _$RegisterStatusImpl>
    implements _$$RegisterStatusImplCopyWith<$Res> {
  __$$RegisterStatusImplCopyWithImpl(
      _$RegisterStatusImpl _value, $Res Function(_$RegisterStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateEventStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? date = null,
    Object? hours = null,
    Object? location = null,
    Object? isError = null,
  }) {
    return _then(_$RegisterStatusImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
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
      {this.title = '',
      this.description = '',
      this.date = '',
      this.hours = '',
      this.location = '',
      this.isError = false});

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String date;
  @override
  @JsonKey()
  final String hours;
  @override
  @JsonKey()
  final String location;
  @override
  @JsonKey()
  final bool isError;

  @override
  String toString() {
    return 'CreateEventStatus(title: $title, description: $description, date: $date, hours: $hours, location: $location, isError: $isError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterStatusImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.isError, isError) || other.isError == isError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, title, description, date, hours, location, isError);

  /// Create a copy of CreateEventStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterStatusImplCopyWith<_$RegisterStatusImpl> get copyWith =>
      __$$RegisterStatusImplCopyWithImpl<_$RegisterStatusImpl>(
          this, _$identity);
}

abstract class _RegisterStatus implements CreateEventStatus {
  factory _RegisterStatus(
      {final String title,
      final String description,
      final String date,
      final String hours,
      final String location,
      final bool isError}) = _$RegisterStatusImpl;

  @override
  String get title;
  @override
  String get description;
  @override
  String get date;
  @override
  String get hours;
  @override
  String get location;
  @override
  bool get isError;

  /// Create a copy of CreateEventStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterStatusImplCopyWith<_$RegisterStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
