import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/mainAppBar.dart';
import 'package:cinefouine/data/entities/movie/movie_info.dart';
import 'package:cinefouine/data/repositories/movie_repository.dart';
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
              return Text(
                "Aucun film trouvé",
                style: const TextStyle(color: Colors.white),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title:
                      Text(movie.title, style: TextStyle(color: Colors.white)),
                  subtitle: Text(movie.id.toString(),
                      style: TextStyle(color: Colors.white70)),
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
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(
              "assets/images/movie_image.png",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
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
                    'Purge - Election Year',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
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
              _buildRecommendationItem(
                imagePath: "assets/images/movie-image.png",
                onAddTap: () {},
                onPlayTap: () {},
              ),
              SizedBox(height: 12),
              _buildRecommendationItem(
                imagePath: "assets/images/movie-image.png",
                onAddTap: () {},
                onPlayTap: () {},
              ),
              SizedBox(height: 12),
              _buildRecommendationItem(
                imagePath: "assets/images/movie-image.png",
                onAddTap: () {},
                onPlayTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationItem({
    required String imagePath,
    required VoidCallback onPlayTap,
    required VoidCallback onAddTap,
  }) {
    return Container(
      width: double.infinity,
      height: 220,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
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
            left: 16,
            bottom: 16,
            child: Row(
              children: [
                GestureDetector(
                  onTap: onPlayTap,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: onAddTap,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
