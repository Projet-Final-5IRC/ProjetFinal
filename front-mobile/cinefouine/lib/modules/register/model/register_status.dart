import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_status.freezed.dart';

@freezed
class RegisterStatus with _$RegisterStatus {
  factory RegisterStatus({
    @Default('') String userName,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String password,
    @Default('') String dateCreation,
    @Default(false) bool isError,
  }) = _RegisterStatus;
}