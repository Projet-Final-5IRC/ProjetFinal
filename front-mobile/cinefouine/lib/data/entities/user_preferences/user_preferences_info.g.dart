// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserPreferenceImpl _$$UserPreferenceImplFromJson(Map<String, dynamic> json) =>
    _$UserPreferenceImpl(
      idGenre: (json['idGenre'] as num).toInt(),
      idPreference: (json['idPreference'] as num).toInt(),
      idUser: (json['idUser'] as num).toInt(),
    );

Map<String, dynamic> _$$UserPreferenceImplToJson(
        _$UserPreferenceImpl instance) =>
    <String, dynamic>{
      'idGenre': instance.idGenre,
      'idPreference': instance.idPreference,
      'idUser': instance.idUser,
    };
