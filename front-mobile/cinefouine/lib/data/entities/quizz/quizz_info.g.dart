// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quizz_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizzImpl _$$QuizzImplFromJson(Map<String, dynamic> json) => _$QuizzImpl(
      titreDuQuizz: json['titreDuQuizz'] as String,
      descriptionDuQuizz: json['descriptionDuQuizz'] as String,
      listeDeQuestions: (json['listeDeQuestions'] as List<dynamic>)
          .map((e) => ListeDeQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$QuizzImplToJson(_$QuizzImpl instance) =>
    <String, dynamic>{
      'titreDuQuizz': instance.titreDuQuizz,
      'descriptionDuQuizz': instance.descriptionDuQuizz,
      'listeDeQuestions': instance.listeDeQuestions,
    };

_$ListeDeQuestionImpl _$$ListeDeQuestionImplFromJson(
        Map<String, dynamic> json) =>
    _$ListeDeQuestionImpl(
      texteDeLaQuestion: json['texteDeLaQuestion'] as String,
      listeDesOptionsDeReponse:
          (json['listeDesOptionsDeReponse'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      reponseCorrecte: json['reponseCorrecte'] as String,
    );

Map<String, dynamic> _$$ListeDeQuestionImplToJson(
        _$ListeDeQuestionImpl instance) =>
    <String, dynamic>{
      'texteDeLaQuestion': instance.texteDeLaQuestion,
      'listeDesOptionsDeReponse': instance.listeDesOptionsDeReponse,
      'reponseCorrecte': instance.reponseCorrecte,
    };
