// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fouine_of_the_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FouineOfTheDayImpl _$$FouineOfTheDayImplFromJson(Map<String, dynamic> json) =>
    _$FouineOfTheDayImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      posterPath: json['poster_path'] as String?,
      runtime: (json['runtime'] as num?)?.toInt(),
      overview: json['overview'] as String?,
      releaseDate: json['releaseDate'] as String?,
      genres:
          (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      actors:
          (json['actors'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$FouineOfTheDayImplToJson(
        _$FouineOfTheDayImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_path': instance.posterPath,
      'runtime': instance.runtime,
      'overview': instance.overview,
      'releaseDate': instance.releaseDate,
      'genres': instance.genres,
      'actors': instance.actors,
    };
