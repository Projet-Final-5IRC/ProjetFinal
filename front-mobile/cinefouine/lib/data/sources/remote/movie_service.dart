import 'dart:convert';
import 'package:cinefouine/data/entities/movie/movie_info.dart';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_service.g.dart';

@Riverpod(keepAlive: true)
MovieService movieService(MovieServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url: "https://ms-movie-e3hcbsdyd9gkd5hy.francecentral-01.azurewebsites.net/api",
  ));
  return MovieService(dioClient: dioClient);
}

class MovieService {
  MovieService({required this.dioClient});

  final DioClient dioClient;

  Future<List<MovieInfo>?> getMovieSuggestions(String query) async {
    final response = await dioClient.get<List<MovieInfo>>(
      '/Movies/suggestions',
      queryParameters: {'query': query},
      deserializer: (json) =>
          MovieListExtension.movieFromJson(jsonEncode(json)),
    );
    return response;
  }
}
