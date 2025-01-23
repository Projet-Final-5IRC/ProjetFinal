// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_info_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieInfoDetailImpl _$$MovieInfoDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$MovieInfoDetailImpl(
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>),
      actors: (json['actors'] as List<dynamic>?)
          ?.map((e) => Actor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MovieInfoDetailImplToJson(
        _$MovieInfoDetailImpl instance) =>
    <String, dynamic>{
      'details': instance.details,
      'actors': instance.actors,
    };

_$DetailsImpl _$$DetailsImplFromJson(Map<String, dynamic> json) =>
    _$DetailsImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      runtime: (json['runtime'] as num?)?.toInt(),
      releaseDate: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DetailsImplToJson(_$DetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'runtime': instance.runtime,
      'release_date': instance.releaseDate?.toIso8601String(),
      'genres': instance.genres,
    };

_$GenreImpl _$$GenreImplFromJson(Map<String, dynamic> json) => _$GenreImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$GenreImplToJson(_$GenreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
