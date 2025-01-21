// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserActionImpl _$$UserActionImplFromJson(Map<String, dynamic> json) =>
    _$UserActionImpl(
      userId: (json['userId'] as num).toInt(),
      loginCount: (json['loginCount'] as num).toInt(),
      quizScore: (json['quizScore'] as num).toInt(),
      moviesWatchedInMonth: (json['moviesWatchedInMonth'] as num).toInt(),
      eventsAttended: (json['eventsAttended'] as num).toInt(),
      daysActive: (json['daysActive'] as num).toInt(),
      reviewsWritten: (json['reviewsWritten'] as num).toInt(),
      uniqueGenresWatched: (json['uniqueGenresWatched'] as num).toInt(),
    );

Map<String, dynamic> _$$UserActionImplToJson(_$UserActionImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'loginCount': instance.loginCount,
      'quizScore': instance.quizScore,
      'moviesWatchedInMonth': instance.moviesWatchedInMonth,
      'eventsAttended': instance.eventsAttended,
      'daysActive': instance.daysActive,
      'reviewsWritten': instance.reviewsWritten,
      'uniqueGenresWatched': instance.uniqueGenresWatched,
    };
