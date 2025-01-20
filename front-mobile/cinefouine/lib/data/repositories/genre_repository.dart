import 'package:cinefouine/data/entities/genre/genre_info.dart';
import 'package:cinefouine/data/sources/remote/genre_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meta/meta.dart';

part 'genre_repository.g.dart';

@Riverpod(keepAlive: true)
GenreRepository genreRepository(GenreRepositoryRef ref) {
  final GenreService genreService = ref.watch(genreServiceProvider);
  return GenreRepository(
    genreService: genreService,
  );
}

@immutable
class GenreRepository {
  const GenreRepository({
    required GenreService genreService,
  }) : _genreService = genreService;

  final GenreService _genreService;

  // Fonction pour récupérer la liste des genres
  Future<List<Genre>?> getGenres() async {
    final genres = await _genreService.getGenres();
    return genres;
  }
}