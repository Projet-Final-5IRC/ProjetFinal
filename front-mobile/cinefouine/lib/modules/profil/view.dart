import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/data/entities/movie/movie_info_detail.dart';
import 'package:cinefouine/data/entities/userAction/user_action.dart';
import 'package:cinefouine/data/repositories/user_preference_repository.dart';
import 'package:cinefouine/data/sources/shared_preference/preferences.dart';
import 'package:cinefouine/modules/detailsMovie/view.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:cinefouine/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class UserActionStat extends _$UserActionStat {
  @override
  Future<UserAction?> build() async {
    final Preferences preferences = ref.read(preferencesProvider);
    try {
      return await ref
          .read(userPreferenceRepositoryProvider)
          .getUserActivity(preferences.idUserPreferences.load()!);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateAction() async {
    final Preferences preferences = ref.read(preferencesProvider);
    try {
      state = AsyncData(
        await ref
            .read(userPreferenceRepositoryProvider)
            .getUserActivity(preferences.idUserPreferences.load()!),
      );
    } catch (e) {
      return;
    }
  }

  Future<void> postUserAction({
    required int idUser,
    required int value,
    required String action,
  }) async {
    try {
      await ref.read(userPreferenceRepositoryProvider).postUserAction(
            userId: idUser,
            value: value,
            actionType: action,
          );
      await updateAction();
    } catch (e) {
      return;
    }
  }
}

@Riverpod(keepAlive: false)
class UserMovieLiked extends _$UserMovieLiked {
  @override
  Future<List<MovieInfoDetail>> build() async {
    state = AsyncLoading();
    final Preferences preferences = ref.read(preferencesProvider);
    final prefRepo = ref.read(userPreferenceRepositoryProvider);
    final movieLiked =
        await prefRepo.getMovieLiked(preferences.idUserPreferences.load()!);
    state = AsyncData(movieLiked);
    return movieLiked;
  }

  Future<void> updateMovieLiked() async {
    state = AsyncLoading();
    final Preferences preferences = ref.read(preferencesProvider);
    final prefRepo = ref.read(userPreferenceRepositoryProvider);
    final movieLiked =
        await prefRepo.getMovieLiked(preferences.idUserPreferences.load()!);
    state = AsyncData(movieLiked);
  }
}

@Riverpod(keepAlive: false)
class UserMovieSeen extends _$UserMovieSeen {
  @override
  Future<List<MovieInfoDetail>> build() async {
    state = AsyncLoading();
    final Preferences preferences = ref.read(preferencesProvider);
    final prefRepo = ref.read(userPreferenceRepositoryProvider);
    final movieSeen =
        await prefRepo.getSeenMovies(preferences.idUserPreferences.load()!);
    state = AsyncData(movieSeen);
    return movieSeen;
  }

  Future<void> updateMovieSeen() async {
    state = AsyncLoading();
    final Preferences preferences = ref.read(preferencesProvider);
    final prefRepo = ref.read(userPreferenceRepositoryProvider);
    final movieSeen =
        await prefRepo.getSeenMovies(preferences.idUserPreferences.load()!);
    state = AsyncData(movieSeen);
  }
}

@RoutePage()
class ProfilView extends ConsumerWidget {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Preferences preferences = ref.watch(preferencesProvider);
    final router = ref.watch(appRouterProvider);
    final userActionAsync = ref.watch(userActionStatProvider);
    final userMovieLikedAsync = ref.watch(userMovieLikedProvider);
    final userMovieSeenAsync = ref.watch(userMovieSeenProvider);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centrer horizontalement
                children: [
                  Stack(
                    clipBehavior:
                        Clip.none, // Permet à l'icône de sortir de la Stack
                    children: [
                      Center(
                        // Centrer l'image dans le Stack
                        child: ClipOval(
                          child: SizedBox(
                            width: 126.0,
                            height: 126.0,
                            child: Image.asset(
                              'assets/images/default_avatar.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            print('Icône cliquée');
                          },
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "Mes infos",
                style: TextStyle(
                  fontSize: 24.0, // Augmenter la taille
                  fontWeight: FontWeight.w700, // Poids de police plus prononcé
                  color: Colors.white,
                  letterSpacing:
                      1.2, // Espacement des lettres pour un effet plus élégant
                ),
              ),

              const SizedBox(height: 16),
              ContactInfoRow(
                icon: Icons.person,
                label: "Nom",
                value:
                    preferences.lastNamePreferences.load() ?? "Non disponible",
              ),
              ContactInfoRow(
                icon: Icons.person_outline,
                label: "Prénom",
                value:
                    preferences.firstNamePreferences.load() ?? "Non disponible",
              ),
              ContactInfoRow(
                icon: Icons.email,
                label: "Email",
                value: preferences.emailPreferences.load() ?? "Non disponible",
              ),
              const SizedBox(height: 16),

              CineFouineHugeBoutton(
                onPressed: () {
                  router.replaceAll([const GenresSelectionRoute()]);
                },
                text: "Choisissez vos genres favoris",
              ),
              const SizedBox(height: 16),
              Text(
                "Mes badges",
                style: TextStyle(
                  fontSize: 24.0, // Augmenter la taille
                  fontWeight: FontWeight.w700, // Poids de police plus prononcé
                  color: Colors.white,
                  letterSpacing:
                      1.2, // Espacement des lettres pour un effet plus élégant
                ),
              ),

              const SizedBox(height: 16),
              userActionAsync.when(
                data: (userAction) {
                  if (userAction == null) {
                    return Text(
                      "Aucune action enregistrée.",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BadgeRow(
                        icon: Icons.login,
                        label: "Nombre de connexions",
                        value: "${userAction.loginCount}",
                      ),
                      BadgeRow(
                        icon: Icons.quiz,
                        label: "Score au quiz",
                        value: "${userAction.quizScore}",
                      ),
                      BadgeRow(
                        icon: Icons.movie,
                        label: "Films regardés ce mois-ci",
                        value: "${userAction.moviesWatchedInMonth}",
                      ),
                      BadgeRow(
                        icon: Icons.event,
                        label: "Événements assistés",
                        value: "${userAction.eventsAttended}",
                      ),
                      BadgeRow(
                        icon: Icons.calendar_today,
                        label: "Jours actifs",
                        value: "${userAction.daysActive}",
                      ),
                      BadgeRow(
                        icon: Icons.rate_review,
                        label: "Critiques écrites",
                        value: "${userAction.reviewsWritten}",
                      ),
                      BadgeRow(
                        icon: Icons.category,
                        label: "Genres uniques regardés",
                        value: "${userAction.uniqueGenresWatched}",
                      ),
                    ],
                  );
                },
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
                error: (err, stack) => Text(
                  "Erreur lors du chargement des actions utilisateur : $err",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(height: 16),
              const SizedBox(height: 16),
              // Boutons et informations utilisateur...
              // Section pour les films likés
              MovieSection(
                title: "Mes films likés",
                moviesAsync: userMovieLikedAsync,
                ref: ref,
                onMovieTap: (movie) {
                  ref.read(movieSeletedProvider.notifier).setMovie(movie);
                  router.push(const DetailsMovieRoute());
                },
              ),
              const SizedBox(height: 24),
              // Section pour les films vus
              MovieSection(
                title: "Mes films vus",
                moviesAsync: userMovieSeenAsync,
                ref: ref,
                onMovieTap: (movie) {
                  ref.read(movieSeletedProvider.notifier).setMovie(movie);
                  router.push(const DetailsMovieRoute());
                },
              ),
              SizedBox(height: 24),
              CineFouineHugeBoutton(
                onPressed: () {
                  preferences.idUserPreferences.save(null);
                  preferences.firstNamePreferences.save(null);
                  preferences.lastNamePreferences.save(null);
                  preferences.emailPreferences.save(null);
                  preferences.userNamePreferences.save(null);

                  router.replaceAll([const LoginRoute()]);
                },
                text: "Logout",
                buttonColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieSection extends StatelessWidget {
  final String title;
  final AsyncValue<List<MovieInfoDetail>> moviesAsync;
  final WidgetRef ref;
  final Function(MovieInfoDetail) onMovieTap;

  const MovieSection({
    required this.title,
    required this.moviesAsync,
    required this.ref,
    required this.onMovieTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        moviesAsync.when(
          data: (movies) {
            if (movies.isEmpty) {
              return Text(
                "Aucun film trouvé.",
                style: TextStyle(color: Colors.white, fontSize: 16),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: movies.map((movie) {
                  final posterUrl = movie.details?.posterPath != null
                      ? 'https://image.tmdb.org/t/p/w500${movie.details?.posterPath}'
                      : 'assets/images/default_poster.jpg';

                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () => onMovieTap(movie),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              posterUrl,
                              width: 120.0,
                              height: 180.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            movie.details?.title ?? "Titre non disponible",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text(
            "Erreur lors du chargement des films : $err",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}

class BadgeRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const BadgeRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 12.0), // Augmenter l'espacement
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(
                10.0), // Augmenter le padding pour donner plus d'espace autour de l'icône
            decoration: BoxDecoration(
              color: AppColors.primary
                  .withOpacity(0.3), // Couleur de fond plus douce
              borderRadius:
                  BorderRadius.circular(12.0), // Arrondir davantage les coins
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 26.0, // Agrandir l'icône
            ),
          ),
          const SizedBox(
              width: 20.0), // Augmenter l'espacement entre l'icône et le texte
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize:
                    18.0, // Augmenter la taille du texte pour une meilleure lisibilité
                fontWeight: FontWeight.w600, // Poids de texte plus équilibré
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold, // Rendre la valeur plus marquée
            ),
          ),
        ],
      ),
    );
  }
}

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ContactInfoRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0), // Espacement accru
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0), // Augmenter le padding
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.3), // Fond doux
              borderRadius: BorderRadius.circular(12.0), // Coins arrondis
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 28.0, // Agrandir l'icône pour plus de visibilité
            ),
          ),
          const SizedBox(width: 20.0), // Espacement
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0, // Taille de texte augmentée
                fontWeight:
                    FontWeight.w600, // Poids de texte pour plus de clarté
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0, // Augmenter la taille du texte
                fontWeight: FontWeight.bold, // Mettre en valeur
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
