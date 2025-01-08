// To parse this JSON data, do
//
//     final eventInfo = eventInfoFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'event_info.freezed.dart';
part 'event_info.g.dart';

List<EventInfo> eventInfoFromJson(String str) => List<EventInfo>.from(json.decode(str).map((x) => EventInfo.fromJson(x)));

String eventInfoToJson(List<EventInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class EventInfo with _$EventInfo {
    const factory EventInfo({
        required int idEvent,
        required String eventName,
        required String eventDate,
        required String eventHour,
        required String eventLocation,
        required String eventDescription,
        required int idGenre,
        required String genreName,
        required int idOwner,
        required String ownerName,
        required List<int> eventInvitationId,
    }) = _EventInfo;

    factory EventInfo.fromJson(Map<String, dynamic> json) => _$EventInfoFromJson(json);
}

extension EventListExtension on List<EventInfo> {
  String eventToJson() =>
      json.encode(List<dynamic>.from(map((x) => x.toJson())));

  static List<EventInfo> eventFromJson(String str) =>
      List<EventInfo>.from((json.decode(str) as List<dynamic>)
          .map((x) => EventInfo.fromJson(x as Map<String, dynamic>)));
}