import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/modules/home/view.dart';
import 'package:cinefouine/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ChooseMovieView extends ConsumerStatefulWidget {
  const ChooseMovieView({super.key});

  @override
  ConsumerState<ChooseMovieView> createState() => _ChooseMovieViewState();
}

class _ChooseMovieViewState extends ConsumerState<ChooseMovieView> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listMovieSearched = ref.watch(listMovieSearchedProvider);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Choose a Movie",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: textController,
              onChanged: (query) {
                if (query.isNotEmpty) {
                  ref.read(listMovieSearchedProvider.notifier).searchMovie(query);
                }
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search for a movie",
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[700]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 16),

            // Movie results
            Expanded(
              child: listMovieSearched.when(
                data: (movies) {
                  if (movies == null || movies.isEmpty) {
                    return const Center(
                      child: Text(
                        "No movies found.",
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return ListTile(
                        leading: movie.posterPath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 75,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.white),
                                ),
                              )
                            : const Icon(Icons.movie, color: Colors.white),
                        title: Text(
                          movie.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          movie.releaseDate?.year.toString() ?? "Unknown Year",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        onTap: () {
                          print("click ${movie.id}"); //TODO ajouter le film a l'event
                        },
                      );
                    },
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}