// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_liked.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieLikedImpl _$$MovieLikedImplFromJson(Map<String, dynamic> json) =>
    _$MovieLikedImpl(
      idLikedMovies: (json['idLikedMovies'] as num).toInt(),
      idTmdbMovie: (json['idTmdbMovie'] as num).toInt(),
      idUser: (json['idUser'] as num).toInt(),
    );

Map<String, dynamic> _$$MovieLikedImplToJson(_$MovieLikedImpl instance) =>
    <String, dynamic>{
      'idLikedMovies': instance.idLikedMovies,
      'idTmdbMovie': instance.idTmdbMovie,
      'idUser': instance.idUser,
    };
