// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quizz_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizzImpl _$$QuizzImplFromJson(Map<String, dynamic> json) => _$QuizzImpl(
      quizId: (json['quizId'] as num).toInt(),
      titreDuQuiz: json['titreDuQuiz'] as String,
      descriptionDuQuiz: json['descriptionDuQuiz'] as String,
      titreDuFilm: json['titreDuFilm'] as String,
      filmId: json['filmId'] as String,
      listeDeQuestions: (json['listeDeQuestions'] as List<dynamic>)
          .map((e) => ListeDeQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$QuizzImplToJson(_$QuizzImpl instance) =>
    <String, dynamic>{
      'quizId': instance.quizId,
      'titreDuQuiz': instance.titreDuQuiz,
      'descriptionDuQuiz': instance.descriptionDuQuiz,
      'titreDuFilm': instance.titreDuFilm,
      'filmId': instance.filmId,
      'listeDeQuestions': instance.listeDeQuestions,
    };

_$ListeDeQuestionImpl _$$ListeDeQuestionImplFromJson(
        Map<String, dynamic> json) =>
    _$ListeDeQuestionImpl(
      questionId: (json['questionId'] as num).toInt(),
      texteDeLaQuestion: json['texteDeLaQuestion'] as String,
      reponseCorrecte: json['reponseCorrecte'] as String,
      quizId: (json['quizId'] as num).toInt(),
      options: (json['options'] as List<dynamic>)
          .map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ListeDeQuestionImplToJson(
        _$ListeDeQuestionImpl instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'texteDeLaQuestion': instance.texteDeLaQuestion,
      'reponseCorrecte': instance.reponseCorrecte,
      'quizId': instance.quizId,
      'options': instance.options,
    };

_$OptionImpl _$$OptionImplFromJson(Map<String, dynamic> json) => _$OptionImpl(
      optionId: (json['optionId'] as num).toInt(),
      texte: json['texte'] as String,
      estCorrecte: json['estCorrecte'] as bool,
      questionId: (json['questionId'] as num).toInt(),
    );

Map<String, dynamic> _$$OptionImplToJson(_$OptionImpl instance) =>
    <String, dynamic>{
      'optionId': instance.optionId,
      'texte': instance.texte,
      'estCorrecte': instance.estCorrecte,
      'questionId': instance.questionId,
    };
