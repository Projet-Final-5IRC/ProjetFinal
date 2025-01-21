import 'dart:convert';
import 'package:cinefouine/data/entities/movie/movie_info.dart';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/data/sources/cine_fouine_endpoints.dart';

part 'recommendation_service.g.dart';


@Riverpod(keepAlive: true)
RecommendationService recommendationService(RecommendationServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url: "https://ms-recommendation-2vhjbhfyf4e6p8fa.francecentral-01.azurewebsites.net/api",
  ));
  return RecommendationService(dioClient: dioClient);
}

class RecommendationService {
  RecommendationService({required this.dioClient});
  final DioClient dioClient;

  Future<List<MovieInfo>?> getRecommendations(int userId) async {
    try {
      final response = await dioClient.get<List<MovieInfo>>(
        CineFouineEndpoints.getRecommendation,
        queryParameters: {'userId': userId},
        deserializer: (json) => MovieListExtension.movieFromJson(jsonEncode(json)),
      );
      return response;
    } catch (e) {
      print('Error getting recommendations: $e');
      return null;
    }
  }
}