import 'package:cinefouine/data/entities/movie/movie_info_detail.dart';
import 'package:cinefouine/data/entities/userAction/user_action.dart';
import 'package:cinefouine/data/entities/user_preferences/user_preferences_info.dart';
import 'package:cinefouine/data/repositories/movie_repository.dart';
import 'package:cinefouine/data/sources/remote/user_preference_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meta/meta.dart';

part 'user_preference_repository.g.dart';

@Riverpod(keepAlive: true)
UserPreferenceRepository userPreferenceRepository(
    UserPreferenceRepositoryRef ref) {
  final UserPreferenceService userPreferenceService =
      ref.watch(userPreferenceServiceProvider);
  final MovieRepository movieRepository = ref.read(movieRepositoryProvider);

  return UserPreferenceRepository(
    userPreferenceService: userPreferenceService,
    movieRepository: movieRepository,
  );
}

@immutable
class UserPreferenceRepository {
  const UserPreferenceRepository({
    required UserPreferenceService userPreferenceService,
    required MovieRepository movieRepository,
  })  : _userPreferenceService = userPreferenceService,
        _movieRepository = movieRepository;

  final UserPreferenceService _userPreferenceService;
  final MovieRepository _movieRepository;

  Future<bool> postUserPreferences(int userId, Set<int> selectedGenres) async {
    return await _userPreferenceService.postUserPreferences(
        userId, selectedGenres);
  }

  Future<bool> updateUserPreferences(
      int userId, List<int> selectedGenres) async {
    return await _userPreferenceService.updateUserPreferences(
        userId, selectedGenres);
  }

  Future<List<UserPreference>?> getUserGenres(int userId) async {
    final userPreferences =
        await _userPreferenceService.getUserPreferences(userId);
    return userPreferences;
  }

  Future<UserAction?> getUserActivity(int userId) async {
    return _userPreferenceService.getUserActivity(userId);
  }

  Future<void> postUserAction({
    required int userId,
    required String actionType,
    required int value,
  }) async {
    return _userPreferenceService.postUserAction(
      actionType: actionType,
      userId: userId,
      value: value,
    );
  }

  Future<void> likeAmovie({
    required int idTmdbMovie,
    required int idUser,
  }) async {
    return _userPreferenceService.likeAmovie(
      idTmdbMovie: idTmdbMovie,
      idUser: idUser,
    );
  }

  Future<List<MovieInfoDetail>> getMovieLiked(int userId) async {
    final movieLiked = await _userPreferenceService.getMovieLiked(userId);
    List<MovieInfoDetail> movieDetailLiked = [];

    for (var movie in movieLiked ?? []) {
      final moviedetail =
          await _movieRepository.getMovieDetails(movie.idTmdbMovie);
      if (moviedetail != null) {
        movieDetailLiked.add(moviedetail);
      }
    }
    return movieDetailLiked;
  }
}
