import 'dart:convert';
import 'package:cinefouine/data/entities/movieLiked/movie_liked.dart';
import 'package:cinefouine/data/entities/userAction/user_action.dart';
import 'package:cinefouine/data/entities/user_preferences/user_preferences_info.dart';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/data/sources/cine_fouine_endpoints.dart';

part 'user_preference_service.g.dart';

@Riverpod(keepAlive: true)
UserPreferenceService userPreferenceService(UserPreferenceServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url:
        "https://ms-usr-cnh6hyfehwe3d4fc.francecentral-01.azurewebsites.net/api",
  ));
  return UserPreferenceService(dioClient: dioClient);
}

class UserPreferenceService {
  UserPreferenceService({required this.dioClient});
  final DioClient dioClient;

  Future<bool> postUserPreferences(int userId, Set<int> genreIds) async {
    final endpoint = CineFouineEndpoints.postPreferenceToUser;

    final List<Map<String, int>> body = genreIds
        .map((genreId) => {"idUser": userId, "idGenre": genreId})
        .toList();
    debugPrint("Error posting preferences: ");

    try {
      final apiResult = await dioClient.post(
        endpoint,
        data: body,
      );
      debugPrint("apiResult: $apiResult");
      return apiResult != null;
    } catch (e) {
      debugPrint("Error posting preferences: $e");
      return false;
    }
  }

  Future<bool> updateUserPreferences(int userId, List<int> genreIds) async {
    final endpoint =
        "${CineFouineEndpoints.updatePreferenceToUser}?IdUser=$userId";

    final List<Map<String, int>> body = genreIds
        .map((genreId) => {"idUser": userId, "idGenre": genreId})
        .toList();
    print(body);

    try {
      await dioClient.put(
        endpoint,
        data: body,
      );
      return true;
    } catch (e) {
      debugPrint("Error posting preferences: $e");
      return false;
    }
  }

  Future<List<UserPreference>?> getUserPreferences(int userId) async {
    final endpoint = "${CineFouineEndpoints.getUserPreference}?id=$userId";
    final apiResult = await dioClient.get<List<UserPreference>>(
      endpoint,
      deserializer: (json) =>
          UserPreferenceListExtension.userPreferenceFromJson(jsonEncode(json)),
    );
    return apiResult;
  }

  Future<void> postUserAction({
    required int userId,
    required String actionType,
    required int value,
  }) async {
    final endpoint = '/UserActivity/LogAction';
    final logUserData = {
      "UserId": userId,
      "ActionType": actionType,
      "Value": value,
    };
    dioClient.post(
      endpoint,
      data: logUserData,
    );
  }

  Future<UserAction?> getUserActivity(int userId) async {
    final endpoint = '/UserActivity/GetUserActivity/$userId';
    final apiResult = await dioClient.get<UserAction>(
      endpoint,
      deserializer: (json) => UserAction.fromJson(json as Map<String, dynamic>),
    );
    return apiResult;
  }

  Future<void> likeAmovie({
    required int idTmdbMovie,
    required int idUser,
  }) async {
    final endpoint = '/UserMovie/AddLikedMovie';
    final likeAmovieData = {
      "idTmdbMovie": idTmdbMovie,
      "idUser": idUser,
    };
    final apiResult = await dioClient.post(
      endpoint,
      data: likeAmovieData,
    );
    return apiResult;
  }

  Future<List<MovieLiked>?> getMovieLiked(int userId) async {
    final endpoint = '/UserMovie/GetAllLikedMovieByUser?userId=$userId';
    final apiResult = await dioClient.get<List<MovieLiked>?>(
      endpoint,
      deserializer: (json) => MovieLikedListExtension.movieLikedFromJson(jsonEncode(json)),
    );
    return apiResult;
  }
}
