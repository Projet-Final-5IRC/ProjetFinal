// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_seen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieSeenImpl _$$MovieSeenImplFromJson(Map<String, dynamic> json) =>
    _$MovieSeenImpl(
      idSeenMovies: (json['idSeenMovies'] as num).toInt(),
      idTmdbMovie: (json['idTmdbMovie'] as num).toInt(),
      idUser: (json['idUser'] as num).toInt(),
    );

Map<String, dynamic> _$$MovieSeenImplToJson(_$MovieSeenImpl instance) =>
    <String, dynamic>{
      'idSeenMovies': instance.idSeenMovies,
      'idTmdbMovie': instance.idTmdbMovie,
      'idUser': instance.idUser,
    };
