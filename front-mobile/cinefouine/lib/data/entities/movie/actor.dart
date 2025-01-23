import 'package:freezed_annotation/freezed_annotation.dart';

part 'actor.freezed.dart';
part 'actor.g.dart';

@freezed
class Actor with _$Actor {
    const factory Actor({
        required int? id,
        required String? name,
        required String? character,
        required String? profilePath,
        required double? popularity,
    }) = _Actor;

    factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
}