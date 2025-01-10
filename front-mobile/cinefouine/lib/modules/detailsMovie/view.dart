import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/mainAppBar.dart';
import 'package:cinefouine/data/entities/movie/movie_info.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:cinefouine/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';

part 'view.g.dart';

@Riverpod(keepAlive: true)
class MovieSeleted extends _$MovieSeleted {
  @override
  MovieInfo? build() => null;

  void setMovie(MovieInfo value) {
    state = value;
  }
}

@RoutePage()
class DetailsMovieView extends ConsumerWidget {
  const DetailsMovieView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieSelected = ref.watch(movieSeletedProvider);
    final router = ref.watch(appRouterProvider);

    if (movieSelected == null) {
      return Scaffold(
        appBar: MainAppBar(
          title: "Details Film",
          isBackNavigationAvailable: router.canNavigateBack,
          onBackButtonPressed: () => router.maybePop(),
        ),
        backgroundColor: AppColors.secondary,
        body: const Center(
          child: Text(
            "Aucun film sélectionné.",
            style: TextStyle(color: AppColors.white),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: MainAppBar(
        title: "Details Film",
        isBackNavigationAvailable: router.canNavigateBack,
        onBackButtonPressed: () => router.maybePop(),
      ),
        backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMovieHeader(movieSelected),
            const SizedBox(height: 16),
            Text(
              movieSelected.overview ?? "Aucune description disponible.",
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            _buildActorsSection(),
            const SizedBox(height: 16),
            CineFouineHugeBoutton( 
                       onPressed: () {},
                      text: "Quiz"),
            const SizedBox(height: 16),
            _buildRatingSection(),
            const SizedBox(height: 16),
            _buildCommentsSection(),
          ],
        ),
      ),
    );
  }

Widget _buildMovieHeader(MovieInfo movie) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (movie.posterPath != null)
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Année: ${movie.releaseDate?.year ?? "Inconnue"}",
              style: const TextStyle(color: AppColors.white, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Cinefouineboutton(onPressed: () {}, text: "Regarder"),
                const SizedBox(width: 8),
                Container(
                  width: 40, // Taille du cercle
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary, // Contour bleu
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.thumb_up, color: AppColors.white),
                    onPressed: () {},
                    iconSize: 20, // Taille du pouce
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40, // Taille du cercle
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.red, // Contour rouge
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.thumb_down, color: AppColors.white),
                    onPressed: () {},
                    iconSize: 20, // Taille du pouce
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}



  Widget _buildActorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Actors",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://via.placeholder.com/80",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Henry Cavill",
                    style: TextStyle(color: AppColors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Note",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
            5,
            (index) => const Icon(
              Icons.star,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Commentaire",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: "Écrire un commentaire ...",
            hintStyle: const TextStyle(color: AppColors.white),
            filled: true,
            fillColor: AppColors.primary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildCommentItem(
          avatarUrl: "https://via.placeholder.com/40",
          comment:
              "Je suis devenu une personne différente depuis que j'ai vu cette masterclass",
        ),
      ],
    );
  }

  Widget _buildCommentItem({required String avatarUrl, required String comment}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(avatarUrl),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              comment,
              style: const TextStyle(color: AppColors.white, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}