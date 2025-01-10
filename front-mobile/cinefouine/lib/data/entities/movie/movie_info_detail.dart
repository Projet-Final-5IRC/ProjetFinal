// To parse this JSON data, do
//
//     final movieInfoDetail = movieInfoDetailFromJson(jsonString);

import 'package:cinefouine/data/entities/movie/actor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'movie_info_detail.freezed.dart';
part 'movie_info_detail.g.dart';

MovieInfoDetail movieInfoDetailFromJson(String str) => MovieInfoDetail.fromJson(json.decode(str));

String movieInfoDetailToJson(MovieInfoDetail data) => json.encode(data.toJson());

@freezed
class MovieInfoDetail with _$MovieInfoDetail {
    const factory MovieInfoDetail({
        required Details? details,
        required List<Actor>? actors,
    }) = _MovieInfoDetail;

    factory MovieInfoDetail.fromJson(Map<String, dynamic> json) => _$MovieInfoDetailFromJson(json);
}

extension MovieDetailListExtension on List<MovieInfoDetail> {
  String movieDetailToJson() =>
      json.encode(List<dynamic>.from(map((x) => x.toJson())));

  static List<MovieInfoDetail> movieDetailFromJson(String str) =>
      List<MovieInfoDetail>.from((json.decode(str) as List<dynamic>)
          .map((x) => MovieInfoDetail.fromJson(x as Map<String, dynamic>)));
}

@freezed
class Details with _$Details {
    const factory Details({
        required String? title,
        required String? overview,
        @JsonKey(name: 'poster_path') required String? posterPath,
        required int? runtime,
        @JsonKey(name: 'release_date') required DateTime? releaseDate,
        required List<Genre>? genres,
    }) = _Details;

    factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);
}

@freezed
class Genre with _$Genre {
    const factory Genre({
        required int? id,
        required String? name,
    }) = _Genre;

    factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}