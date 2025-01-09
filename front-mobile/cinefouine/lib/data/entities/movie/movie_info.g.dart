// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieInfoImpl _$$MovieInfoImplFromJson(Map<String, dynamic> json) =>
    _$MovieInfoImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
<<<<<<< HEAD
=======
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      popularity: (json['popularity'] as num?)?.toDouble(),
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
>>>>>>> 3400e68ac9f10d092a5ada2bdcf5c82ef2efa6df
    );

Map<String, dynamic> _$$MovieInfoImplToJson(_$MovieInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
<<<<<<< HEAD
=======
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate?.toIso8601String(),
      'popularity': instance.popularity,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
>>>>>>> 3400e68ac9f10d092a5ada2bdcf5c82ef2efa6df
    };
