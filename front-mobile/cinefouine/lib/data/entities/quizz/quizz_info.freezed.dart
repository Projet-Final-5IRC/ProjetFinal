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
  String get titreDuQuizz => throw _privateConstructorUsedError;
  String get descriptionDuQuizz => throw _privateConstructorUsedError;
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
      {String titreDuQuizz,
      String descriptionDuQuizz,
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
    Object? titreDuQuizz = null,
    Object? descriptionDuQuizz = null,
    Object? listeDeQuestions = null,
  }) {
    return _then(_value.copyWith(
      titreDuQuizz: null == titreDuQuizz
          ? _value.titreDuQuizz
          : titreDuQuizz // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionDuQuizz: null == descriptionDuQuizz
          ? _value.descriptionDuQuizz
          : descriptionDuQuizz // ignore: cast_nullable_to_non_nullable
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
      {String titreDuQuizz,
      String descriptionDuQuizz,
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
    Object? titreDuQuizz = null,
    Object? descriptionDuQuizz = null,
    Object? listeDeQuestions = null,
  }) {
    return _then(_$QuizzImpl(
      titreDuQuizz: null == titreDuQuizz
          ? _value.titreDuQuizz
          : titreDuQuizz // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionDuQuizz: null == descriptionDuQuizz
          ? _value.descriptionDuQuizz
          : descriptionDuQuizz // ignore: cast_nullable_to_non_nullable
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
      {required this.titreDuQuizz,
      required this.descriptionDuQuizz,
      required final List<ListeDeQuestion> listeDeQuestions})
      : _listeDeQuestions = listeDeQuestions;

  factory _$QuizzImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizzImplFromJson(json);

  @override
  final String titreDuQuizz;
  @override
  final String descriptionDuQuizz;
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
    return 'Quizz(titreDuQuizz: $titreDuQuizz, descriptionDuQuizz: $descriptionDuQuizz, listeDeQuestions: $listeDeQuestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizzImpl &&
            (identical(other.titreDuQuizz, titreDuQuizz) ||
                other.titreDuQuizz == titreDuQuizz) &&
            (identical(other.descriptionDuQuizz, descriptionDuQuizz) ||
                other.descriptionDuQuizz == descriptionDuQuizz) &&
            const DeepCollectionEquality()
                .equals(other._listeDeQuestions, _listeDeQuestions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, titreDuQuizz, descriptionDuQuizz,
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
      {required final String titreDuQuizz,
      required final String descriptionDuQuizz,
      required final List<ListeDeQuestion> listeDeQuestions}) = _$QuizzImpl;

  factory _Quizz.fromJson(Map<String, dynamic> json) = _$QuizzImpl.fromJson;

  @override
  String get titreDuQuizz;
  @override
  String get descriptionDuQuizz;
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
  String get texteDeLaQuestion => throw _privateConstructorUsedError;
  List<String> get listeDesOptionsDeReponse =>
      throw _privateConstructorUsedError;
  String get reponseCorrecte => throw _privateConstructorUsedError;

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
      {String texteDeLaQuestion,
      List<String> listeDesOptionsDeReponse,
      String reponseCorrecte});
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
    Object? texteDeLaQuestion = null,
    Object? listeDesOptionsDeReponse = null,
    Object? reponseCorrecte = null,
  }) {
    return _then(_value.copyWith(
      texteDeLaQuestion: null == texteDeLaQuestion
          ? _value.texteDeLaQuestion
          : texteDeLaQuestion // ignore: cast_nullable_to_non_nullable
              as String,
      listeDesOptionsDeReponse: null == listeDesOptionsDeReponse
          ? _value.listeDesOptionsDeReponse
          : listeDesOptionsDeReponse // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reponseCorrecte: null == reponseCorrecte
          ? _value.reponseCorrecte
          : reponseCorrecte // ignore: cast_nullable_to_non_nullable
              as String,
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
      {String texteDeLaQuestion,
      List<String> listeDesOptionsDeReponse,
      String reponseCorrecte});
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
    Object? texteDeLaQuestion = null,
    Object? listeDesOptionsDeReponse = null,
    Object? reponseCorrecte = null,
  }) {
    return _then(_$ListeDeQuestionImpl(
      texteDeLaQuestion: null == texteDeLaQuestion
          ? _value.texteDeLaQuestion
          : texteDeLaQuestion // ignore: cast_nullable_to_non_nullable
              as String,
      listeDesOptionsDeReponse: null == listeDesOptionsDeReponse
          ? _value._listeDesOptionsDeReponse
          : listeDesOptionsDeReponse // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reponseCorrecte: null == reponseCorrecte
          ? _value.reponseCorrecte
          : reponseCorrecte // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListeDeQuestionImpl implements _ListeDeQuestion {
  const _$ListeDeQuestionImpl(
      {required this.texteDeLaQuestion,
      required final List<String> listeDesOptionsDeReponse,
      required this.reponseCorrecte})
      : _listeDesOptionsDeReponse = listeDesOptionsDeReponse;

  factory _$ListeDeQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListeDeQuestionImplFromJson(json);

  @override
  final String texteDeLaQuestion;
  final List<String> _listeDesOptionsDeReponse;
  @override
  List<String> get listeDesOptionsDeReponse {
    if (_listeDesOptionsDeReponse is EqualUnmodifiableListView)
      return _listeDesOptionsDeReponse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listeDesOptionsDeReponse);
  }

  @override
  final String reponseCorrecte;

  @override
  String toString() {
    return 'ListeDeQuestion(texteDeLaQuestion: $texteDeLaQuestion, listeDesOptionsDeReponse: $listeDesOptionsDeReponse, reponseCorrecte: $reponseCorrecte)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListeDeQuestionImpl &&
            (identical(other.texteDeLaQuestion, texteDeLaQuestion) ||
                other.texteDeLaQuestion == texteDeLaQuestion) &&
            const DeepCollectionEquality().equals(
                other._listeDesOptionsDeReponse, _listeDesOptionsDeReponse) &&
            (identical(other.reponseCorrecte, reponseCorrecte) ||
                other.reponseCorrecte == reponseCorrecte));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      texteDeLaQuestion,
      const DeepCollectionEquality().hash(_listeDesOptionsDeReponse),
      reponseCorrecte);

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
      {required final String texteDeLaQuestion,
      required final List<String> listeDesOptionsDeReponse,
      required final String reponseCorrecte}) = _$ListeDeQuestionImpl;

  factory _ListeDeQuestion.fromJson(Map<String, dynamic> json) =
      _$ListeDeQuestionImpl.fromJson;

  @override
  String get texteDeLaQuestion;
  @override
  List<String> get listeDesOptionsDeReponse;
  @override
  String get reponseCorrecte;

  /// Create a copy of ListeDeQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListeDeQuestionImplCopyWith<_$ListeDeQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
