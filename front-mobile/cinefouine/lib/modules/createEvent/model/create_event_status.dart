import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_event_status.freezed.dart';

@freezed
class CreateEventStatus with _$CreateEventStatus {
  factory CreateEventStatus({
    @Default('') String title,
    @Default('') String description,
    @Default('') String date,
    @Default('') String hours,
    @Default('') String location,
    @Default(false) bool isError,
  }) = _RegisterStatus;
}
