import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/mainAppBar.dart';
import 'package:cinefouine/data/entities/movie/fouine_of_the_day.dart';
import 'package:cinefouine/data/entities/movie/movie_info.dart';
import 'package:cinefouine/data/entities/movie/movie_info_detail.dart';
import 'package:cinefouine/data/repositories/movie_repository.dart';
import 'package:cinefouine/data/repositories/recommendation_repository.dart';
import 'package:cinefouine/data/sources/shared_preference/preferences.dart';
import 'package:cinefouine/modules/detailsMovie/view.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:cinefouine/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class ListMovieSearched extends _$ListMovieSearched {
  @override
  FutureOr<List<MovieInfo>?> build() async {
    return [];
  }

  Future<List<MovieInfo>?> searchMovie(String query) async {
    final repo = ref.read(movieRepositoryProvider);
    final results = await repo.getMovieSuggestions(query);
    state = AsyncValue.data(results);
    return results;
  }
}

@Riverpod(keepAlive: false)
class FouineOfTHeDay extends _$FouineOfTHeDay {
  @override
  FutureOr<FouineOfTheDay?> build() async {
    return ref.read(recommendationRepositoryProvider).getFouineOfTheDay();
  }
}

@Riverpod(keepAlive: false)
Future<List<MovieInfo>?> getRecommendations(
  Ref ref,
) async {
  final preferences = ref.read(preferencesProvider);
  return ref
      .watch(recommendationRepositoryProvider)
      .getRecommendations(preferences.idUserPreferences.load()!);
}

@RoutePage()
class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchModeActif = ref.watch(isSearchModeActifProvider);
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: isSearchModeActif ? SearchContent() : HomeContent(),
      ),
    );
  }
}

class SearchContent extends ConsumerWidget {
  const SearchContent({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ref.watch(listMovieSearchedProvider).when(
          data: (movies) {
            if (movies == null || movies.isEmpty) {
              return const Center(
                child: Text(
                  "Aucun film trouvé",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(movie: movie);
              },
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(
                'Erreur: $error',
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}

class MovieCard extends ConsumerWidget {
  final MovieInfo movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return InkWell(
      onTap: () {
        ref.read(movieSeletedProvider.notifier).setMovie(movie);
        router.push(DetailsMovieRoute());
      },
      child: Card(
        elevation: 4,
        color: AppColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: movie.posterPath != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
            ),

            // Movie Info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (movie.releaseDate != null)
                    Text(
                      '${movie.releaseDate?.year}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  const SizedBox(height: 4),
                  if (movie.voteAverage != null)
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage!.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPlaceholder() {
  return Container(
    color: Colors.grey[800],
    child: const Center(
      child: Icon(
        Icons.movie_outlined,
        color: Colors.white54,
        size: 48,
      ),
    ),
  );
}

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendationsAsyncValue = ref.watch(getRecommendationsProvider);
    final fouineOfTheDay = ref.watch(fouineOfTHeDayProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fouineOfTheDay.when(
          data: (data) {
            return Stack(
              children: [
                Image.network(
                  data?.posterPath != null
                      ? 'https://image.tmdb.org/t/p/w500${data?.posterPath}'
                      : '',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.grey,
                      child: Icon(Icons.broken_image, color: Colors.white),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.secondary,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fouine of the day',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data?.title ?? "",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        data?.overview ?? "",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return CircularProgressIndicator();
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieInfoBar(
                duration: "130",
                imdbRating: "imb",
                releaseYear: "2022",
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        print("click play on platform");
                      },
                      icon: SvgPicture.asset("assets/icons/playbutton.svg"),
                      label: Text('Play on platform'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        print("click add to watchlist");
                      },
                      icon: Icon(Icons.add),
                      label: Text('Add to watchlist'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.white),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Vous pourriez aimer...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),

              // Utilisation de la méthode getRecommendations
              recommendationsAsyncValue.when(
                data: (movies) {
                  // print("DEBUG Recommendations: $movies");
                  if (movies == null || movies.isEmpty) {
                    return const Center(
                      child: Text(
                        "Aucune recommandation",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      final router = ref.watch(appRouterProvider);

                      return _buildRecommendationItem(
                        imagePath:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        title: movie.title,
                        description: movie.overview ?? '',
                        onAddTap: () {},
                        onPlayTap: () {},
                        onTap: () {
                          // Action à effectuer lors du clic
                          ref
                              .read(movieSeletedProvider.notifier)
                              .setMovie(movie);
                          router.push(DetailsMovieRoute());
                        },
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Text(
                      'Erreur: $error',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationItem({
    required String imagePath,
    required String title,
    required String description,
    required VoidCallback onPlayTap,
    required VoidCallback onAddTap,
    required VoidCallback onTap, // Nouveau paramètre pour l'action onTap
  }) {
    return GestureDetector(
      onTap: onTap, // Déclenchement de l'action lors du clic
      child: Container(
        width: double.infinity,
        height: 250,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholder(),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieInfoBar extends StatelessWidget {
  final String imdbRating;
  final String releaseYear;
  final String duration;

  const MovieInfoBar({
    super.key,
    required this.imdbRating,
    required this.releaseYear,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF2C465C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildInfoSection(
              title: 'Qualification',
              value: 'IMDb $imdbRating',
              flex: 2,
            ),
            _buildVerticalDivider(),
            _buildInfoSection(
              title: 'Release year',
              value: releaseYear,
              flex: 2,
            ),
            _buildVerticalDivider(),
            _buildInfoSection(
              title: 'Duration',
              value: '$duration min',
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required String value,
    required int flex,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      margin: EdgeInsets.symmetric(vertical: 12),
      color: Colors.white.withOpacity(0.1),
    );
  }
}
