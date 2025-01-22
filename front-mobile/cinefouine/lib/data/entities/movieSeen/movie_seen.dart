// To parse this JSON data, do
//
//     final movieSeen = movieSeenFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'movie_seen.freezed.dart';
part 'movie_seen.g.dart';

List<MovieSeen> movieSeenFromJson(String str) => List<MovieSeen>.from(json.decode(str).map((x) => MovieSeen.fromJson(x)));

String movieSeenToJson(List<MovieSeen> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class MovieSeen with _$MovieSeen {
    const factory MovieSeen({
        required int idSeenMovies,
        required int idTmdbMovie,
        required int idUser,
    }) = _MovieSeen;

    factory MovieSeen.fromJson(Map<String, dynamic> json) => _$MovieSeenFromJson(json);
}

extension MovieSeenListExtension on List<MovieSeen> {
  // Convertir une liste de Genre en JSON
  String movieSeenToJson() =>
      json.encode(List<dynamic>.from(map((x) => x.toJson())));

  // Convertir un JSON en liste de Genre
  static List<MovieSeen> movieSeenFromJson(String str) =>
      List<MovieSeen>.from((json.decode(str) as List<dynamic>)
          .map((x) => MovieSeen.fromJson(x as Map<String, dynamic>)));
}