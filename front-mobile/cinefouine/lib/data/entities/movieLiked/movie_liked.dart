// To parse this JSON data, do
//
//     final movieLiked = movieLikedFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'movie_liked.freezed.dart';
part 'movie_liked.g.dart';

List<MovieLiked> movieLikedFromJson(String str) => List<MovieLiked>.from(json.decode(str).map((x) => MovieLiked.fromJson(x)));

String movieLikedToJson(List<MovieLiked> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class MovieLiked with _$MovieLiked {
    const factory MovieLiked({
        required int idLikedMovies,
        required int idTmdbMovie,
        required int idUser,
    }) = _MovieLiked;

    factory MovieLiked.fromJson(Map<String, dynamic> json) => _$MovieLikedFromJson(json);
}

extension MovieLikedListExtension on List<MovieLiked> {
  // Convertir une liste de Genre en JSON
  String movieLikedToJson() =>
      json.encode(List<dynamic>.from(map((x) => x.toJson())));

  // Convertir un JSON en liste de Genre
  static List<MovieLiked> movieLikedFromJson(String str) =>
      List<MovieLiked>.from((json.decode(str) as List<dynamic>)
          .map((x) => MovieLiked.fromJson(x as Map<String, dynamic>)));
}