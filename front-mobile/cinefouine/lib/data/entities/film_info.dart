// To parse this JSON data, do
//
//     final filmInfo = filmInfoFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'film_info.freezed.dart';
part 'film_info.g.dart';

List<FilmInfo> filmInfoFromJson(String str) => List<FilmInfo>.from(json.decode(str).map((x) => FilmInfo.fromJson(x)));

String filmInfoToJson(List<FilmInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class FilmInfo with _$FilmInfo {
    const factory FilmInfo({
        required int id,
        required String title,
    }) = _FilmInfo;

    factory FilmInfo.fromJson(Map<String, dynamic> json) => _$FilmInfoFromJson(json);
}