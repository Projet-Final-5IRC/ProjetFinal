// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventInfoImpl _$$EventInfoImplFromJson(Map<String, dynamic> json) =>
    _$EventInfoImpl(
      idEvent: (json['idEvent'] as num).toInt(),
      eventName: json['eventName'] as String,
      eventDate: json['eventDate'] as String,
      eventHour: json['eventHour'] as String,
      eventLocation: json['eventLocation'] as String,
      eventDescription: json['eventDescription'] as String,
      idGenre: (json['idGenre'] as num?)?.toInt(),
      genreName: json['genreName'] as String?,
      eventInvitationId: json['eventInvitationId'] as List<dynamic>,
    );

Map<String, dynamic> _$$EventInfoImplToJson(_$EventInfoImpl instance) =>
    <String, dynamic>{
      'idEvent': instance.idEvent,
      'eventName': instance.eventName,
      'eventDate': instance.eventDate,
      'eventHour': instance.eventHour,
      'eventLocation': instance.eventLocation,
      'eventDescription': instance.eventDescription,
      'idGenre': instance.idGenre,
      'genreName': instance.genreName,
      'eventInvitationId': instance.eventInvitationId,
    };
