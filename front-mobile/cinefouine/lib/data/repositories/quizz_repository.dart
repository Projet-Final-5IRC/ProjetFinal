import 'package:cinefouine/data/entities/quizz/quizz_info.dart';
import 'package:cinefouine/data/sources/remote/quizz_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meta/meta.dart';

part 'quizz_repository.g.dart';

@Riverpod(keepAlive: true)
QuizzRepository quizzRepository(QuizzRepositoryRef ref) {
  final QuizzService quizzService = ref.watch(quizzServiceProvider);
  return QuizzRepository(
    quizzService: quizzService,
  );
}

@immutable
class QuizzRepository {
  const QuizzRepository({
    required QuizzService quizzService,
  }) : _quizzService = quizzService;

  final QuizzService _quizzService;

  Future<List<Quizz>?> getQuizz() async {
    final quizz = await _quizzService.getQuizz();
    return quizz;
  }
}
