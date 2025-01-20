import 'dart:convert';
import 'package:cinefouine/data/entities/genre/genre_info.dart';
import 'package:cinefouine/data/entities/user/user_info.dart';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/data/sources/cine_fouine_endpoints.dart';

part 'genre_service.g.dart';

@Riverpod(keepAlive: true)
GenreService genreService(GenreServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url:
        "https://ms-data-f9bvgcewdvchayha.francecentral-01.azurewebsites.net/api",
  ));
  return GenreService(dioClient: dioClient);
}

class GenreService {
  GenreService({required this.dioClient});
  final DioClient dioClient;

  Future<List<Genre>?> getGenres() async {
    final endpoint = CineFouineEndpoints.getGenres;
    final apiResult = await dioClient.get<List<Genre>>(
      endpoint,
      deserializer: (json) =>
          GenreListExtension.genreFromJson(jsonEncode(json)),
    );
    debugPrint("apiResult: $apiResult");
    return apiResult;
  }

  Future<List<UserInfo>?> getAllUsers() async {
    final endpoint = "/User";
    final apiResult = await dioClient.get<List<UserInfo>>(
      endpoint,
      deserializer: (json) =>
          UserListExtension.userFromJson(jsonEncode(json)),
    );
    debugPrint("apiResult: $apiResult");
    return apiResult;
  }
}
