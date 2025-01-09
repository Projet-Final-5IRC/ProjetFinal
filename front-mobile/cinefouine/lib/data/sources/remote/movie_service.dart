import 'dart:convert';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_service.g.dart';

@Riverpod(keepAlive: true)
MovieService movieService(MovieServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url: "https://ms-movie-e3hcbsdyd9gkd5hy.francecentral-01.azurewebsites.net/api/Movies/suggestions",
  ));
  return MovieService(dioClient: dioClient);
}

class MovieService {
  MovieService({required this.dioClient});

  final DioClient dioClient;

  Future<List<String>> getMovieSuggestions(String query) async {
    try {
      // Log avant la requête
      debugPrint('APP-DEBUG: Envoi de la requête pour le query "$query"');

      // Exécute la requête
      final response = await dioClient.get(
        '',
        queryParameters: {'query': query},
      );

      // Log après la requête
      debugPrint('APP-DEBUG: Réponse reçue - $response');

      // Vérifiez si le `response` est valide
      if (response == null) {
        throw Exception('Réponse nulle, vérifiez l’API ou la connexion réseau.');
      }

      // Log du statusCode
      debugPrint('APP-DEBUG: StatusCode: ${response.statusCode}');

      // Vérifiez si le `statusCode` est 200
      if (response.statusCode == 200) {
        // Log des données
        debugPrint('APP-DEBUG: Données reçues : ${response}');

        // Vérifiez et retournez les données
        if (response.data is List) {
          final List<dynamic> data = response.data;
          return data.map((item) {
            if (item is Map<String, dynamic> && item.containsKey('title')) {
              return item['title'] as String;
            }
            throw Exception('Format inattendu des données dans la liste');
          }).toList();
        } else {
          throw Exception(
              'Format inattendu de la réponse, attendu une liste JSON.');
        }
      } else {
        throw Exception(
            'Erreur HTTP : ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e, stacktrace) {
      debugPrint('APP-DEBUG: Erreur lors de la récupération des suggestions : $e');
      debugPrint('APP-DEBUG: Stacktrace : $stacktrace');
      rethrow; // Renvoyer l'erreur pour gestion ultérieure
    }
  }
}
