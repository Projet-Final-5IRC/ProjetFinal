// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platforme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlatformeImpl _$$PlatformeImplFromJson(Map<String, dynamic> json) =>
    _$PlatformeImpl(
      providerName: json['providerName'] as String,
      logoPath: json['logoPath'] as String,
      type: json['type'] as String,
      tmdbLink: json['tmdbLink'] as String,
    );

Map<String, dynamic> _$$PlatformeImplToJson(_$PlatformeImpl instance) =>
    <String, dynamic>{
      'providerName': instance.providerName,
      'logoPath': instance.logoPath,
      'type': instance.type,
      'tmdbLink': instance.tmdbLink,
    };
