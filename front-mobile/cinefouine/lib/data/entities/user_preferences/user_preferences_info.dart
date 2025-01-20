import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_preferences_info.freezed.dart';
part 'user_preferences_info.g.dart';

// Pour désérialiser le JSON en une liste d'objets Genre
List<UserPreference> genreFromJson(String str) =>
    List<UserPreference>.from(json.decode(str).map((x) => UserPreference.fromJson(x)));

// Pour convertir une liste d'objets Genre en JSON
String genreToJson(List<UserPreference> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class UserPreference with _$UserPreference {
  const factory UserPreference({
    required int idGenre,
    required int idPreference,
    required int idUser,
  }) = _UserPreference;

  // Fonction pour désérialiser un Genre à partir de JSON
  factory UserPreference.fromJson(Map<String, dynamic> json) => _$UserPreferenceFromJson(json);
}

extension UserPreferenceListExtension on List<UserPreference> {
  // Convertir une liste de Genre en JSON
  String userPreferenceToJson() =>
      json.encode(List<dynamic>.from(map((x) => x.toJson())));

  // Convertir un JSON en liste de Genre
  static List<UserPreference> userPreferenceFromJson(String str) =>
      List<UserPreference>.from((json.decode(str) as List<dynamic>)
          .map((x) => UserPreference.fromJson(x as Map<String, dynamic>)));
}
