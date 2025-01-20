import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/data/repositories/genre_repository.dart';
import 'package:cinefouine/data/repositories/user_preference_repository.dart';
import 'package:cinefouine/data/sources/shared_preference/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefouine/data/entities/genre/genre_info.dart';
import 'package:cinefouine/data/sources/remote/genre_service.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';

// Provider pour charger les genres
final genresProvider = FutureProvider<List<Genre>>((ref) async {
  final genreService = ref.read(genreServiceProvider);
  return await genreService.getGenres() ?? [];
});


// StateNotifier pour gérer les sélections
class SelectedGenresNotifier extends StateNotifier<Set<int>> {
  SelectedGenresNotifier() : super({});

  void toggleGenre(int genreId) {
    if (state.contains(genreId)) {
      state = {...state}..remove(genreId);
    } else {
      state = {...state}..add(genreId);
    }
  }

  void clearSelection() {
    state = {};
  }
}

final selectedGenresProvider =
    StateNotifierProvider<SelectedGenresNotifier, Set<int>>(
        (ref) => SelectedGenresNotifier());

@RoutePage()
class GenresSelectionView extends ConsumerWidget {
  const GenresSelectionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genresAsync = ref.watch(genresProvider);
    final selectedGenres = ref.watch(selectedGenresProvider);
    final selectedGenresNotifier = ref.read(selectedGenresProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1F25), // Fond de la page
      appBar: AppBar(
        title: const Text(
          'Sélectionner vos Genres préférés',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A1F25), // Couleur de fond de l'app bar
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
                      crossAxisCount: 3, // Trois genres par ligne
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                    ),
                    itemCount: genres.length,
                    itemBuilder: (context, index) {
                      final genre = genres[index];
                      final isSelected = selectedGenres.contains(genre.idGenre);

                      return GestureDetector(
                        onTap: () {
                          selectedGenresNotifier.toggleGenre(genre.idGenre);
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: isSelected
                              ? Colors.blueAccent
                              : Colors.grey[200],
                          child: Center(
                            child: Text(
                              genre.genreName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black87,
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
                      final repository = ref.read(userPreferenceRepositoryProvider);
                      final userId = preferences.idUserPreferences.load() ?? 1;
                      print('userId: $userId'); 
                      try {
                        final success = await repository.updateUserPreferences(userId, selectedGenres);
                        
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
