import 'package:cinefouine/data/entities/movie/movie_info.dart';
import 'package:cinefouine/data/entities/movie/movie_info_detail.dart';
import 'package:cinefouine/data/entities/platforme/platforme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/data/sources/remote/movie_service.dart';
import 'package:meta/meta.dart';

part 'movie_repository.g.dart';

@Riverpod(keepAlive: true)
MovieRepository movieRepository(MovieRepositoryRef ref) {
  final MovieService movieService = ref.watch(movieServiceProvider);
  return MovieRepository(
    appApiClient: movieService,
  );
}

@immutable
class MovieRepository {
  const MovieRepository({
    required MovieService appApiClient,
  }) : _appApiClient = appApiClient;

  final MovieService _appApiClient;

  Future<List<MovieInfo>?> getMovieSuggestions(String query) async {
    final suggestions = await _appApiClient.getMovieSuggestions(query);
    return suggestions;
  }

  Future<MovieInfoDetail?> getMovieDetails(int movieId) async {
    final movieDetails = await _appApiClient.getMovieDetails(movieId);
    return movieDetails;
  }

  Future<List<Platforme>?> getPlatformeMovie(int movieId) async {
    return _appApiClient.getPlatformeMovie(movieId);
  }
}
