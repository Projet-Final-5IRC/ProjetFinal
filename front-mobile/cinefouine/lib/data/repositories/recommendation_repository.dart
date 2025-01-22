import 'package:cinefouine/data/entities/movie/fouine_of_the_day.dart';
import 'package:cinefouine/data/entities/movie/movie_info.dart';
import 'package:cinefouine/data/entities/movie/movie_info_detail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/data/sources/remote/recommendation_service.dart';
import 'package:meta/meta.dart';

part 'recommendation_repository.g.dart';

@Riverpod(keepAlive: true)
RecommendationRepository recommendationRepository(
    RecommendationRepositoryRef ref) {
  final RecommendationService recommendationService =
      ref.watch(recommendationServiceProvider);
  return RecommendationRepository(
    recommendationService: recommendationService,
  );
}

@immutable
class RecommendationRepository {
  const RecommendationRepository({
    required RecommendationService recommendationService,
  }) : _recommendationService = recommendationService;

  final RecommendationService _recommendationService;

  Future<List<MovieInfo>?> getRecommendations(int userId) async {
    final recommendations =
        await _recommendationService.getRecommendations(userId);
    return recommendations;
  }

  Future<FouineOfTheDay?> getFouineOfTheDay() async {
    return _recommendationService.getFouineOfTheDay();
  }
}
