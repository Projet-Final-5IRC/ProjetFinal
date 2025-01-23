// quizz_repository.dart
import 'package:cinefouine/data/entities/quizz/quizz_info.dart';
import 'package:cinefouine/data/sources/remote/quizz_signalr_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meta/meta.dart';

part 'quizz_repository.g.dart';

@Riverpod(keepAlive: true)
QuizzRepository quizzRepository(QuizzRepositoryRef ref) {
  final QuizSignalRService quizSignalRService = ref.watch(quizSignalRServiceProvider);
  return QuizzRepository(quizSignalRService: quizSignalRService);
}

@immutable
@immutable
class QuizzRepository {
  const QuizzRepository({
    required QuizSignalRService quizSignalRService,
  }) : _quizSignalRService = quizSignalRService;

  final QuizSignalRService _quizSignalRService;

  // Retourner une liste de quizzes, même si l'API renvoie un seul quiz
  Future<List<Quizz>?> getQuizzForFilm(int filmId, String title) async {
    try {
      final quiz = await _quizSignalRService.getQuizzForFilm(filmId, title);
      
      // Vérifiez si un quiz est retourné et enveloppez-le dans une liste
      if (quiz != null) {
        return [quiz];  // Retourner une liste contenant un seul quiz
      }
      return null;  // Retourner null si aucun quiz n'est trouvé
    } catch (e) {
      print("DEBUG Error in repository getting quiz for film $filmId: $e");
      return null;
    }
  }

  Stream<Map<String, String>> get quizReadyStream => _quizSignalRService.quizReadyStream;
}
