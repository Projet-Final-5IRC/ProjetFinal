// To parse this JSON data, do
//
//     final platforme = platformeFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'platforme.freezed.dart';
part 'platforme.g.dart';

List<Platforme> platformeFromJson(String str) => List<Platforme>.from(json.decode(str).map((x) => Platforme.fromJson(x)));

String platformeToJson(List<Platforme> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class Platforme with _$Platforme {
    const factory Platforme({
        required String providerName,
        required String logoPath,
        required String type,
        required String tmdbLink,
    }) = _Platforme;

    factory Platforme.fromJson(Map<String, dynamic> json) => _$PlatformeFromJson(json);
}

extension PlatformeListExtension on List<Platforme> {
  // Convertir une liste de Genre en JSON
  String platformeToJson() =>
      json.encode(List<dynamic>.from(map((x) => x.toJson())));

  // Convertir un JSON en liste de Genre
  static List<Platforme> platformeFromJson(String str) =>
      List<Platforme>.from((json.decode(str) as List<dynamic>)
          .map((x) => Platforme.fromJson(x as Map<String, dynamic>)));
}