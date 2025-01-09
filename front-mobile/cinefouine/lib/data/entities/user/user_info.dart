// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_info.freezed.dart';
part 'user_info.g.dart';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

@freezed
class UserInfo with _$UserInfo {
    const factory UserInfo({
        required int idUser,
        required String userName,
        required String firstName,
        required String lastName,
        required String email,
        required String dateCreation,
    }) = _UserInfo;

    factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
}