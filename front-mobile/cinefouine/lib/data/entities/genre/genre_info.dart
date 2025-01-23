import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'genre_info.freezed.dart';
part 'genre_info.g.dart';

// Pour désérialiser le JSON en une liste d'objets Genre
List<Genre> genreFromJson(String str) =>
    List<Genre>.from(json.decode(str).map((x) => Genre.fromJson(x)));

// Pour convertir une liste d'objets Genre en JSON
String genreToJson(List<Genre> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class Genre with _$Genre {
  const factory Genre({
    required int idGenre,
    required String genreName, // Le nom du genre
  }) = _Genre;

  // Fonction pour désérialiser un Genre à partir de JSON
  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}

extension GenreListExtension on List<Genre> {
  // Convertir une liste de Genre en JSON
  String genreToJson() =>
      json.encode(List<dynamic>.from(map((x) => x.toJson())));

  // Convertir un JSON en liste de Genre
  static List<Genre> genreFromJson(String str) =>
      List<Genre>.from((json.decode(str) as List<dynamic>)
          .map((x) => Genre.fromJson(x as Map<String, dynamic>)));
}
