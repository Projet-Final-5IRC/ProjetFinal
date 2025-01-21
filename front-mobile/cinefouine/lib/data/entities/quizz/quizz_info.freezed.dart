// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quizz_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Quizz _$QuizzFromJson(Map<String, dynamic> json) {
  return _Quizz.fromJson(json);
}

/// @nodoc
mixin _$Quizz {
  int get quizId => throw _privateConstructorUsedError;
  String get titreDuQuiz => throw _privateConstructorUsedError;
  String get descriptionDuQuiz => throw _privateConstructorUsedError;
  String get titreDuFilm => throw _privateConstructorUsedError;
  String get filmId => throw _privateConstructorUsedError;
  List<ListeDeQuestion> get listeDeQuestions =>
      throw _privateConstructorUsedError;

  /// Serializes this Quizz to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Quizz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizzCopyWith<Quizz> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizzCopyWith<$Res> {
  factory $QuizzCopyWith(Quizz value, $Res Function(Quizz) then) =
      _$QuizzCopyWithImpl<$Res, Quizz>;
  @useResult
  $Res call(
      {int quizId,
      String titreDuQuiz,
      String descriptionDuQuiz,
      String titreDuFilm,
      String filmId,
      List<ListeDeQuestion> listeDeQuestions});
}

/// @nodoc
class _$QuizzCopyWithImpl<$Res, $Val extends Quizz>
    implements $QuizzCopyWith<$Res> {
  _$QuizzCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Quizz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quizId = null,
    Object? titreDuQuiz = null,
    Object? descriptionDuQuiz = null,
    Object? titreDuFilm = null,
    Object? filmId = null,
    Object? listeDeQuestions = null,
  }) {
    return _then(_value.copyWith(
      quizId: null == quizId
          ? _value.quizId
          : quizId // ignore: cast_nullable_to_non_nullable
              as int,
      titreDuQuiz: null == titreDuQuiz
          ? _value.titreDuQuiz
          : titreDuQuiz // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionDuQuiz: null == descriptionDuQuiz
          ? _value.descriptionDuQuiz
          : descriptionDuQuiz // ignore: cast_nullable_to_non_nullable
              as String,
      titreDuFilm: null == titreDuFilm
          ? _value.titreDuFilm
          : titreDuFilm // ignore: cast_nullable_to_non_nullable
              as String,
      filmId: null == filmId
          ? _value.filmId
          : filmId // ignore: cast_nullable_to_non_nullable
              as String,
      listeDeQuestions: null == listeDeQuestions
          ? _value.listeDeQuestions
          : listeDeQuestions // ignore: cast_nullable_to_non_nullable
              as List<ListeDeQuestion>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizzImplCopyWith<$Res> implements $QuizzCopyWith<$Res> {
  factory _$$QuizzImplCopyWith(
          _$QuizzImpl value, $Res Function(_$QuizzImpl) then) =
      __$$QuizzImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int quizId,
      String titreDuQuiz,
      String descriptionDuQuiz,
      String titreDuFilm,
      String filmId,
      List<ListeDeQuestion> listeDeQuestions});
}

/// @nodoc
class __$$QuizzImplCopyWithImpl<$Res>
    extends _$QuizzCopyWithImpl<$Res, _$QuizzImpl>
    implements _$$QuizzImplCopyWith<$Res> {
  __$$QuizzImplCopyWithImpl(
      _$QuizzImpl _value, $Res Function(_$QuizzImpl) _then)
      : super(_value, _then);

  /// Create a copy of Quizz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quizId = null,
    Object? titreDuQuiz = null,
    Object? descriptionDuQuiz = null,
    Object? titreDuFilm = null,
    Object? filmId = null,
    Object? listeDeQuestions = null,
  }) {
    return _then(_$QuizzImpl(
      quizId: null == quizId
          ? _value.quizId
          : quizId // ignore: cast_nullable_to_non_nullable
              as int,
      titreDuQuiz: null == titreDuQuiz
          ? _value.titreDuQuiz
          : titreDuQuiz // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionDuQuiz: null == descriptionDuQuiz
          ? _value.descriptionDuQuiz
          : descriptionDuQuiz // ignore: cast_nullable_to_non_nullable
              as String,
      titreDuFilm: null == titreDuFilm
          ? _value.titreDuFilm
          : titreDuFilm // ignore: cast_nullable_to_non_nullable
              as String,
      filmId: null == filmId
          ? _value.filmId
          : filmId // ignore: cast_nullable_to_non_nullable
              as String,
      listeDeQuestions: null == listeDeQuestions
          ? _value._listeDeQuestions
          : listeDeQuestions // ignore: cast_nullable_to_non_nullable
              as List<ListeDeQuestion>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizzImpl implements _Quizz {
  const _$QuizzImpl(
      {required this.quizId,
      required this.titreDuQuiz,
      required this.descriptionDuQuiz,
      required this.titreDuFilm,
      required this.filmId,
      required final List<ListeDeQuestion> listeDeQuestions})
      : _listeDeQuestions = listeDeQuestions;

  factory _$QuizzImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizzImplFromJson(json);

  @override
  final int quizId;
  @override
  final String titreDuQuiz;
  @override
  final String descriptionDuQuiz;
  @override
  final String titreDuFilm;
  @override
  final String filmId;
  final List<ListeDeQuestion> _listeDeQuestions;
  @override
  List<ListeDeQuestion> get listeDeQuestions {
    if (_listeDeQuestions is EqualUnmodifiableListView)
      return _listeDeQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listeDeQuestions);
  }

  @override
  String toString() {
    return 'Quizz(quizId: $quizId, titreDuQuiz: $titreDuQuiz, descriptionDuQuiz: $descriptionDuQuiz, titreDuFilm: $titreDuFilm, filmId: $filmId, listeDeQuestions: $listeDeQuestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizzImpl &&
            (identical(other.quizId, quizId) || other.quizId == quizId) &&
            (identical(other.titreDuQuiz, titreDuQuiz) ||
                other.titreDuQuiz == titreDuQuiz) &&
            (identical(other.descriptionDuQuiz, descriptionDuQuiz) ||
                other.descriptionDuQuiz == descriptionDuQuiz) &&
            (identical(other.titreDuFilm, titreDuFilm) ||
                other.titreDuFilm == titreDuFilm) &&
            (identical(other.filmId, filmId) || other.filmId == filmId) &&
            const DeepCollectionEquality()
                .equals(other._listeDeQuestions, _listeDeQuestions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      quizId,
      titreDuQuiz,
      descriptionDuQuiz,
      titreDuFilm,
      filmId,
      const DeepCollectionEquality().hash(_listeDeQuestions));

  /// Create a copy of Quizz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizzImplCopyWith<_$QuizzImpl> get copyWith =>
      __$$QuizzImplCopyWithImpl<_$QuizzImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizzImplToJson(
      this,
    );
  }
}

abstract class _Quizz implements Quizz {
  const factory _Quizz(
      {required final int quizId,
      required final String titreDuQuiz,
      required final String descriptionDuQuiz,
      required final String titreDuFilm,
      required final String filmId,
      required final List<ListeDeQuestion> listeDeQuestions}) = _$QuizzImpl;

  factory _Quizz.fromJson(Map<String, dynamic> json) = _$QuizzImpl.fromJson;

  @override
  int get quizId;
  @override
  String get titreDuQuiz;
  @override
  String get descriptionDuQuiz;
  @override
  String get titreDuFilm;
  @override
  String get filmId;
  @override
  List<ListeDeQuestion> get listeDeQuestions;

  /// Create a copy of Quizz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizzImplCopyWith<_$QuizzImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ListeDeQuestion _$ListeDeQuestionFromJson(Map<String, dynamic> json) {
  return _ListeDeQuestion.fromJson(json);
}

/// @nodoc
mixin _$ListeDeQuestion {
  int get questionId => throw _privateConstructorUsedError;
  String get texteDeLaQuestion => throw _privateConstructorUsedError;
  String get reponseCorrecte => throw _privateConstructorUsedError;
  int get quizId => throw _privateConstructorUsedError;
  List<Option> get options => throw _privateConstructorUsedError;

  /// Serializes this ListeDeQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListeDeQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListeDeQuestionCopyWith<ListeDeQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListeDeQuestionCopyWith<$Res> {
  factory $ListeDeQuestionCopyWith(
          ListeDeQuestion value, $Res Function(ListeDeQuestion) then) =
      _$ListeDeQuestionCopyWithImpl<$Res, ListeDeQuestion>;
  @useResult
  $Res call(
      {int questionId,
      String texteDeLaQuestion,
      String reponseCorrecte,
      int quizId,
      List<Option> options});
}

/// @nodoc
class _$ListeDeQuestionCopyWithImpl<$Res, $Val extends ListeDeQuestion>
    implements $ListeDeQuestionCopyWith<$Res> {
  _$ListeDeQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListeDeQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? texteDeLaQuestion = null,
    Object? reponseCorrecte = null,
    Object? quizId = null,
    Object? options = null,
  }) {
    return _then(_value.copyWith(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      texteDeLaQuestion: null == texteDeLaQuestion
          ? _value.texteDeLaQuestion
          : texteDeLaQuestion // ignore: cast_nullable_to_non_nullable
              as String,
      reponseCorrecte: null == reponseCorrecte
          ? _value.reponseCorrecte
          : reponseCorrecte // ignore: cast_nullable_to_non_nullable
              as String,
      quizId: null == quizId
          ? _value.quizId
          : quizId // ignore: cast_nullable_to_non_nullable
              as int,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Option>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListeDeQuestionImplCopyWith<$Res>
    implements $ListeDeQuestionCopyWith<$Res> {
  factory _$$ListeDeQuestionImplCopyWith(_$ListeDeQuestionImpl value,
          $Res Function(_$ListeDeQuestionImpl) then) =
      __$$ListeDeQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int questionId,
      String texteDeLaQuestion,
      String reponseCorrecte,
      int quizId,
      List<Option> options});
}

/// @nodoc
class __$$ListeDeQuestionImplCopyWithImpl<$Res>
    extends _$ListeDeQuestionCopyWithImpl<$Res, _$ListeDeQuestionImpl>
    implements _$$ListeDeQuestionImplCopyWith<$Res> {
  __$$ListeDeQuestionImplCopyWithImpl(
      _$ListeDeQuestionImpl _value, $Res Function(_$ListeDeQuestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListeDeQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? texteDeLaQuestion = null,
    Object? reponseCorrecte = null,
    Object? quizId = null,
    Object? options = null,
  }) {
    return _then(_$ListeDeQuestionImpl(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      texteDeLaQuestion: null == texteDeLaQuestion
          ? _value.texteDeLaQuestion
          : texteDeLaQuestion // ignore: cast_nullable_to_non_nullable
              as String,
      reponseCorrecte: null == reponseCorrecte
          ? _value.reponseCorrecte
          : reponseCorrecte // ignore: cast_nullable_to_non_nullable
              as String,
      quizId: null == quizId
          ? _value.quizId
          : quizId // ignore: cast_nullable_to_non_nullable
              as int,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Option>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListeDeQuestionImpl implements _ListeDeQuestion {
  const _$ListeDeQuestionImpl(
      {required this.questionId,
      required this.texteDeLaQuestion,
      required this.reponseCorrecte,
      required this.quizId,
      required final List<Option> options})
      : _options = options;

  factory _$ListeDeQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListeDeQuestionImplFromJson(json);

  @override
  final int questionId;
  @override
  final String texteDeLaQuestion;
  @override
  final String reponseCorrecte;
  @override
  final int quizId;
  final List<Option> _options;
  @override
  List<Option> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'ListeDeQuestion(questionId: $questionId, texteDeLaQuestion: $texteDeLaQuestion, reponseCorrecte: $reponseCorrecte, quizId: $quizId, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListeDeQuestionImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.texteDeLaQuestion, texteDeLaQuestion) ||
                other.texteDeLaQuestion == texteDeLaQuestion) &&
            (identical(other.reponseCorrecte, reponseCorrecte) ||
                other.reponseCorrecte == reponseCorrecte) &&
            (identical(other.quizId, quizId) || other.quizId == quizId) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, questionId, texteDeLaQuestion,
      reponseCorrecte, quizId, const DeepCollectionEquality().hash(_options));

  /// Create a copy of ListeDeQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListeDeQuestionImplCopyWith<_$ListeDeQuestionImpl> get copyWith =>
      __$$ListeDeQuestionImplCopyWithImpl<_$ListeDeQuestionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListeDeQuestionImplToJson(
      this,
    );
  }
}

abstract class _ListeDeQuestion implements ListeDeQuestion {
  const factory _ListeDeQuestion(
      {required final int questionId,
      required final String texteDeLaQuestion,
      required final String reponseCorrecte,
      required final int quizId,
      required final List<Option> options}) = _$ListeDeQuestionImpl;

  factory _ListeDeQuestion.fromJson(Map<String, dynamic> json) =
      _$ListeDeQuestionImpl.fromJson;

  @override
  int get questionId;
  @override
  String get texteDeLaQuestion;
  @override
  String get reponseCorrecte;
  @override
  int get quizId;
  @override
  List<Option> get options;

  /// Create a copy of ListeDeQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListeDeQuestionImplCopyWith<_$ListeDeQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Option _$OptionFromJson(Map<String, dynamic> json) {
  return _Option.fromJson(json);
}

/// @nodoc
mixin _$Option {
  int get optionId => throw _privateConstructorUsedError;
  String get texte => throw _privateConstructorUsedError;
  bool get estCorrecte => throw _privateConstructorUsedError;
  int get questionId => throw _privateConstructorUsedError;

  /// Serializes this Option to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OptionCopyWith<Option> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptionCopyWith<$Res> {
  factory $OptionCopyWith(Option value, $Res Function(Option) then) =
      _$OptionCopyWithImpl<$Res, Option>;
  @useResult
  $Res call({int optionId, String texte, bool estCorrecte, int questionId});
}

/// @nodoc
class _$OptionCopyWithImpl<$Res, $Val extends Option>
    implements $OptionCopyWith<$Res> {
  _$OptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optionId = null,
    Object? texte = null,
    Object? estCorrecte = null,
    Object? questionId = null,
  }) {
    return _then(_value.copyWith(
      optionId: null == optionId
          ? _value.optionId
          : optionId // ignore: cast_nullable_to_non_nullable
              as int,
      texte: null == texte
          ? _value.texte
          : texte // ignore: cast_nullable_to_non_nullable
              as String,
      estCorrecte: null == estCorrecte
          ? _value.estCorrecte
          : estCorrecte // ignore: cast_nullable_to_non_nullable
              as bool,
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OptionImplCopyWith<$Res> implements $OptionCopyWith<$Res> {
  factory _$$OptionImplCopyWith(
          _$OptionImpl value, $Res Function(_$OptionImpl) then) =
      __$$OptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int optionId, String texte, bool estCorrecte, int questionId});
}

/// @nodoc
class __$$OptionImplCopyWithImpl<$Res>
    extends _$OptionCopyWithImpl<$Res, _$OptionImpl>
    implements _$$OptionImplCopyWith<$Res> {
  __$$OptionImplCopyWithImpl(
      _$OptionImpl _value, $Res Function(_$OptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optionId = null,
    Object? texte = null,
    Object? estCorrecte = null,
    Object? questionId = null,
  }) {
    return _then(_$OptionImpl(
      optionId: null == optionId
          ? _value.optionId
          : optionId // ignore: cast_nullable_to_non_nullable
              as int,
      texte: null == texte
          ? _value.texte
          : texte // ignore: cast_nullable_to_non_nullable
              as String,
      estCorrecte: null == estCorrecte
          ? _value.estCorrecte
          : estCorrecte // ignore: cast_nullable_to_non_nullable
              as bool,
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OptionImpl implements _Option {
  const _$OptionImpl(
      {required this.optionId,
      required this.texte,
      required this.estCorrecte,
      required this.questionId});

  factory _$OptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$OptionImplFromJson(json);

  @override
  final int optionId;
  @override
  final String texte;
  @override
  final bool estCorrecte;
  @override
  final int questionId;

  @override
  String toString() {
    return 'Option(optionId: $optionId, texte: $texte, estCorrecte: $estCorrecte, questionId: $questionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptionImpl &&
            (identical(other.optionId, optionId) ||
                other.optionId == optionId) &&
            (identical(other.texte, texte) || other.texte == texte) &&
            (identical(other.estCorrecte, estCorrecte) ||
                other.estCorrecte == estCorrecte) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, optionId, texte, estCorrecte, questionId);

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OptionImplCopyWith<_$OptionImpl> get copyWith =>
      __$$OptionImplCopyWithImpl<_$OptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OptionImplToJson(
      this,
    );
  }
}

abstract class _Option implements Option {
  const factory _Option(
      {required final int optionId,
      required final String texte,
      required final bool estCorrecte,
      required final int questionId}) = _$OptionImpl;

  factory _Option.fromJson(Map<String, dynamic> json) = _$OptionImpl.fromJson;

  @override
  int get optionId;
  @override
  String get texte;
  @override
  bool get estCorrecte;
  @override
  int get questionId;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OptionImplCopyWith<_$OptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
