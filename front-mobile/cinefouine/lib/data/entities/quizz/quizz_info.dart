// To parse this JSON data, do
//
//     final quizz = quizzFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'quizz_info.freezed.dart';
part 'quizz_info.g.dart';

Quizz quizzFromJson(String str) => Quizz.fromJson(json.decode(str));

String quizzToJson(Quizz data) => json.encode(data.toJson());

@freezed
class Quizz with _$Quizz {
    const factory Quizz({
        required String titreDuQuizz,
        required String descriptionDuQuizz,
        required List<ListeDeQuestion> listeDeQuestions,
    }) = _Quizz;

    factory Quizz.fromJson(Map<String, dynamic> json) => _$QuizzFromJson(json);
}

@freezed
class ListeDeQuestion with _$ListeDeQuestion {
    const factory ListeDeQuestion({
        required String texteDeLaQuestion,
        required List<String> listeDesOptionsDeReponse,
        required String reponseCorrecte,
    }) = _ListeDeQuestion;

    factory ListeDeQuestion.fromJson(Map<String, dynamic> json) => _$ListeDeQuestionFromJson(json);
}

extension QuizzListExtension on List<Quizz> {
  String quizzToJson() =>
      json.encode(List<dynamic>.from(map((x) => x.toJson())));

  static List<Quizz> quizzFromJson(String str) =>
      List<Quizz>.from((json.decode(str) as List<dynamic>)
          .map((x) => Quizz.fromJson(x as Map<String, dynamic>)));
}