import 'dart:ffi';
import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/data/repositories/quizz_repository.dart';
import 'package:cinefouine/data/sources/remote/quizz_signalr_service.dart';
import 'package:cinefouine/modules/detailsMovie/view.dart';
import 'package:cinefouine/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'dart:async';

@RoutePage()
class QuizView extends ConsumerStatefulWidget {
  const QuizView({super.key});

  @override
  ConsumerState<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends ConsumerState<QuizView> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  String _selectedAnswer = "";
  StreamSubscription? _quizReadySubscription;

  bool _isLoading = true; // Indicateur pour savoir si le quiz est en cours de chargement

  Map<String, dynamic> _quizData = {
    "titre_du_quizz": "Chargement du quiz en cours",
    "description_du_quizz": "",
    "liste_de_questions": [],
  };

  @override
  void initState() {
    super.initState();
    _setupSignalRListener();
    final movieSelected = ref.read(movieSeletedProvider);

    int id = movieSelected.value?.details?.id ?? 0;
    String title = movieSelected.value?.details?.title ?? "";
    _loadNewQuiz(id, title); // Call _loadNewQuiz with a default filmId
  }

  void _setupSignalRListener() {
    final signalRService = ref.read(quizSignalRServiceProvider);
    _quizReadySubscription = signalRService.quizReadyStream.listen((quizData) {
      if (mounted) {
         final filmId = int.parse(quizData['filmId']!);
          print("DEBUG infos id $filmId, info titre ${quizData['titreDuFilm']}"); 
        _loadNewQuiz(filmId, quizData['titreDuFilm']!);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Nouveau quiz disponible pour: ${quizData['titreDuFilm']}'),
        //     action: SnackBarAction(
        //       label: 'Voir',
        //       onPressed: () {
        //             final filmId = int.parse(quizData['filmId']!);
        //             print("DEBUG infos id $filmId, info titre ${quizData['titreDuFilm']}"); 
        //              _loadNewQuiz(filmId, quizData['titreDuFilm']!);
        //       },
        //     ),
        //   ),
        // );
      }
    });
  }

  Future<void> _loadNewQuiz(int filmId, String title) async {
    try {
      setState(() {
        _isLoading = true; // Commencer le chargement
      });

      print("DEBUG Loading new quiz for film $title");
      final newQuizzes = await ref.read(quizzRepositoryProvider).getQuizzForFilm(filmId, title);

      if (newQuizzes == null || newQuizzes.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Aucun quiz disponible pour ce film'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        setState(() {
          _isLoading = false; // Fin du chargement si pas de quiz
        });
        return;
      }

      // On prend le premier quiz de la liste
      final newQuiz = newQuizzes.first;

      setState(() {
        _currentQuestionIndex = 0;
        _score = 0;
        _isAnswered = false;
        _selectedAnswer = "";
        _quizData = {
          "titre_du_quizz": newQuiz.titreDuQuiz,
          "description_du_quizz": newQuiz.descriptionDuQuiz,
          "liste_de_questions": newQuiz.listeDeQuestions.map((question) => {
            "texte_de_la_question": question.texteDeLaQuestion,
            "liste_des_options_de_reponse": question.options.map((option) => option.texte).toList(),
            "reponse_correcte": question.reponseCorrecte,
          }).toList(),
        };
        _isLoading = false; // Fin du chargement
      });

      // Notification de succès optionnelle
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Quiz "${newQuiz.titreDuQuiz}" chargé avec succès'),
            backgroundColor: Colors.green,
          ),
        );
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors du chargement du quiz: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Réessayer',
              textColor: Colors.white,
              onPressed: () => _loadNewQuiz(filmId, title),
            ),
          ),
        );
      }
      setState(() {
        _isLoading = false; // Fin du chargement en cas d'erreur
      });
    }
  }

  void _submitAnswer() {
    if (_isAnswered || _selectedAnswer.isEmpty) return;

    final currentQuestion = _quizData['liste_de_questions'][_currentQuestionIndex];
    setState(() {
      _isAnswered = true;

      if (_selectedAnswer == currentQuestion['reponse_correcte']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _quizData['liste_de_questions'].length - 1) {
        _currentQuestionIndex++;
        _isAnswered = false;
        _selectedAnswer = "";
      } else {
        _showQuizResult();
      }
    });
  }

  void _showQuizResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Résultats du Quiz"),
          content: Text("Vous avez obtenu $_score/${_quizData['liste_de_questions'].length} bonnes réponses !"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentQuestionIndex = 0;
                  _score = 0;
                  _isAnswered = false;
                  _selectedAnswer = "";
                });
              },
              child: const Text("Recommencer"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _quizReadySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _quizData['liste_de_questions'].isNotEmpty
        ? _quizData['liste_de_questions'][_currentQuestionIndex]
        : null;

    final quizTitle = _quizData['titre_du_quizz'];
    final quizDescription = _quizData['description_du_quizz'];

    return Scaffold(
      backgroundColor: const Color(0xFF243040),
      appBar: AppBar(
        title: Text(quizTitle),
        backgroundColor: const Color(0xFF16213E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              )
            else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      quizDescription,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 24),
              if (_quizData['liste_de_questions'].isNotEmpty)
                Center(
                  child: Text(
                    "${_currentQuestionIndex + 1}/${_quizData['liste_de_questions'].length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 16),
              Text(
                currentQuestion?['texte_de_la_question'] ?? 'Création du quizz en cours...',
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: currentQuestion?['liste_des_options_de_reponse']?.map<Widget>((option) {
                  final isSelected = option == _selectedAnswer;
                  final isCorrect = option == currentQuestion?['reponse_correcte'];
                  return GestureDetector(
                    onTap: () {
                      if (!_isAnswered) {
                        setState(() {
                          _selectedAnswer = option;
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 24,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _isAnswered
                            ? (isCorrect
                                ? Colors.green
                                : (isSelected ? Colors.red : const Color(0xFF34495E)))
                            : (isSelected ? const Color(0xFF1ABC9C) : const Color(0xFF34495E)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        option,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList() ?? [],
              ),
              const SizedBox(height: 24),
              if (!_isAnswered)
                CineFouineHugeBoutton(
                  onPressed: _selectedAnswer.isNotEmpty ? _submitAnswer : () {},
                  text: "Valider",
                  buttonColor: _selectedAnswer.isEmpty ? const Color(0xFF95A5A6) : const Color(0xFF3498DB),
                ),
              if (_isAnswered)
                CineFouineHugeBoutton(
                  onPressed: _nextQuestion,
                  text: _currentQuestionIndex < _quizData['liste_de_questions'].length - 1
                      ? "Suivant"
                      : "Voir Résultats",
                  buttonColor: Colors.green,
                ),
              const SizedBox(height: 32),
            ]
          ],
        ),
      ),
    );
  }
}
