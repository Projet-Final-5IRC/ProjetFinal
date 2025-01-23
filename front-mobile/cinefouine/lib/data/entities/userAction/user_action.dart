// To parse this JSON data, do
//
//     final userAction = userActionFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_action.freezed.dart';
part 'user_action.g.dart';

UserAction userActionFromJson(String str) => UserAction.fromJson(json.decode(str));

String userActionToJson(UserAction data) => json.encode(data.toJson());

@freezed
class UserAction with _$UserAction {
    const factory UserAction({
        required int userId,
        required int loginCount,
        required int quizScore,
        required int moviesWatchedInMonth,
        required int eventsAttended,
        required int daysActive,
        required int reviewsWritten,
        required int uniqueGenresWatched,
    }) = _UserAction;

    factory UserAction.fromJson(Map<String, dynamic> json) => _$UserActionFromJson(json);
}