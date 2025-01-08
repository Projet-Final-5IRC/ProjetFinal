import 'dart:convert';
import 'package:cinefouine/data/sources/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_service.g.dart';

@Riverpod(keepAlive: true)
MovieService movieService(MovieServiceRef ref) {
  final dioClient = ref.watch(dioClientProvider(
    url: "http://localhost:5055/api/Movies/suggestions",
  ));
  return MovieService(dioClient: dioClient);
}

class MovieService {
  MovieService({required this.dioClient});

  final DioClient dioClient;

  Future<List<String>> getMovieSuggestions(String query) async {
    final response = await dioClient.get(
      '',
      queryParameters: {'query': query},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.data);
      return data.map((item) => item['title'] as String).toList();
    } else {
      throw Exception('Failed to load movie suggestions');
    }
  }
}
