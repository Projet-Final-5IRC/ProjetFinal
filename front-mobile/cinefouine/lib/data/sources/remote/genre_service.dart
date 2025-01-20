import 'dart:convert';
import 'dart:ffi';
import 'package:cinefouine/data/entities/genre/genre_info.dart';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/data/sources/cine_fouine_endpoints.dart';

part 'genre_service.g.dart';

@Riverpod(keepAlive: true)
GenreService genreService(GenreServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url: "https://ms-data-f9bvgcewdvchayha.francecentral-01.azurewebsites.net/api", // Remplace par l'URL API des genres si différente
  ));
  return GenreService(dioClient: dioClient);
}

class GenreService {
  GenreService({required this.dioClient});
  final DioClient dioClient;

  // Fonction pour récupérer les genres
  // Future<List<Genre>?> getGenres() async {
  //   final response = await dioClient.get<List<dynamic>>(
  //     '/Genres', // Remplace ce chemin par celui de ton API pour obtenir les genres
  //   );

  //   // Désérialisation de la réponse JSON en une liste de Genre
  //   if (response != null) {
  //     return genreFromJson(jsonEncode(response));
  //   }
  //   return null;
  // }
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

}
