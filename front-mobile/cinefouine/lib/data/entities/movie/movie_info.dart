import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'movie_info.freezed.dart';
part 'movie_info.g.dart';

List<MovieInfo> movieInfoFromJson(String str) => List<MovieInfo>.from(json.decode(str).map((x) => MovieInfo.fromJson(x)));

String movieInfoToJson(List<MovieInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class MovieInfo with _$MovieInfo {
    const factory MovieInfo({
        required int id,
        required String title,
    }) = _MovieInfo;

    factory MovieInfo.fromJson(Map<String, dynamic> json) => _$MovieInfoFromJson(json);
}

extension MovieListExtension on List<MovieInfo> {
  String movieToJson() =>
      json.encode(List<dynamic>.from(map((x) => x.toJson())));

  static List<MovieInfo> movieFromJson(String str) =>
      List<MovieInfo>.from((json.decode(str) as List<dynamic>)
          .map((x) => MovieInfo.fromJson(x as Map<String, dynamic>)));
}