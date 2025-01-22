// To parse this JSON data, do
//
//     final fouineOfTheDay = fouineOfTheDayFromJson(jsonString);

import 'package:cinefouine/data/entities/movie/actor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'fouine_of_the_day.freezed.dart';
part 'fouine_of_the_day.g.dart';

List<FouineOfTheDay> fouineOfTheDayFromJson(String str) => List<FouineOfTheDay>.from(json.decode(str).map((x) => FouineOfTheDay.fromJson(x)));

String fouineOfTheDayToJson(List<FouineOfTheDay> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class FouineOfTheDay with _$FouineOfTheDay {
    const factory FouineOfTheDay({
        required int id,
        required String? title,
        @JsonKey(name: 'poster_path') required String? posterPath,
        required int? runtime,
        required String? overview,
        required String? releaseDate,
        required List<String>? genres,
        required List<String>? actors,
    }) = _FouineOfTheDay;

    factory FouineOfTheDay.fromJson(Map<String, dynamic> json) => _$FouineOfTheDayFromJson(json);
}

extension FouineOfTheDayListExtension on List<FouineOfTheDay> {
  String fouineOfTheDayToJson() =>
      json.encode(List<dynamic>.from(map((x) => x.toJson())));

  static List<FouineOfTheDay> fouineOfTheDayFromJson(String str) =>
      List<FouineOfTheDay>.from((json.decode(str) as List<dynamic>)
          .map((x) => FouineOfTheDay.fromJson(x as Map<String, dynamic>)));
}