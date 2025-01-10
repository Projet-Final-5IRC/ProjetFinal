import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_status.freezed.dart';

@freezed
class LoginStatus with _$LoginStatus {
  factory LoginStatus({
    @Default('') String mail,
    @Default('') String password,
    @Default(false) bool isError,
  }) = _LoginStatus;
}