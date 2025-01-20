import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/data/entities/user_preferences/user_preferences_info.dart';
import 'package:cinefouine/data/repositories/user_preference_repository.dart';
import 'package:cinefouine/data/sources/shared_preference/preferences.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefouine/data/entities/genre/genre_info.dart';
import 'package:cinefouine/data/sources/remote/genre_service.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view.g.dart';

@Riverpod(keepAlive: false)
class Genres extends _$Genres {
  @override
  Future<List<Genre>?> build() async {
    return ref.watch(genreServiceProvider).getGenres();
  }

  Future<void> updateUsers() async {
    state = AsyncValue.data(await ref.watch(genreServiceProvider).getGenres());
  }
}

@Riverpod(keepAlive: false)
class UserGenres extends _$UserGenres {
  @override
  Future<List<UserPreference>?> build() async {
    AsyncValue.loading();
    final preferences = ref.read(preferencesProvider);

    if (preferences.idUserPreferences.load() != null) {
      int idUser = preferences.idUserPreferences.load()!;
      final userGenre = await ref.read(userPreferenceRepositoryProvider).getUserGenres(idUser);
      final selectedGenresNotifier = ref.read(selectedGenresProvider.notifier);
      userGenre?.forEach((genre) {
        selectedGenresNotifier.toggleGenre(genre.idGenre);
      });
      return userGenre;
    } else {
      return [];
    }
  }
}

@Riverpod(keepAlive: false)
class SelectedGenres extends _$SelectedGenres {
  @override
  List<int> build() {
    return [];
  }

  void toggleGenre(int genreId) {
    if (state.contains(genreId)) {
      state = List.from(state)..remove(genreId);
    } else {
      state = List.from(state)..add(genreId);
    }
  }

  /// Réinitialise la sélection des genres
  void clearSelection() {
    state = [];
  }
}

@RoutePage()
class GenresSelectionView extends ConsumerWidget {
  const GenresSelectionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final genresAsync = ref.watch(genresProvider);
    final selectedGenres = ref.watch(selectedGenresProvider);
    final selectedGenresNotifier = ref.read(selectedGenresProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1F25),
      appBar: AppBar(
        title: const Text(
          'Sélectionner vos Genres préférés',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A1F25),
      ),
      body: genresAsync.when(
        data: (genres) {
          final Preferences preferences = ref.read(preferencesProvider);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                    ),
                    itemCount: genres?.length,
                    itemBuilder: (context, index) {
                      final genre = genres?[index];
                      final isSelected =
                          selectedGenres.contains(genre?.idGenre);

                      return GestureDetector(
                        onTap: () {
                          selectedGenresNotifier
                              .toggleGenre(genre?.idGenre ?? 0);
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color:
                              isSelected ? Colors.blueAccent : Colors.grey[200],
                          child: Center(
                            child: Text(
                              genre?.genreName ?? "Unknow",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Bouton de confirmation
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CineFouineHugeBoutton(
                    onPressed: () async {
                      final repository =
                          ref.read(userPreferenceRepositoryProvider);
                      final userId = preferences.idUserPreferences.load() ?? 1;
                      try {
                        final success = await repository.updateUserPreferences(
                            userId, selectedGenres);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? 'Préférences sauvegardées avec succès'
                                    : 'Erreur lors de la sauvegarde',
                              ),
                            ),
                          );
                        }
                        if (success) router.replaceAll([const HomeRoute()]);
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erreur: ${e.toString()}'),
                            ),
                          );
                        }
                      }
                    },
                    text: "Confirmer",
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text(
            'Erreur : $error',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
