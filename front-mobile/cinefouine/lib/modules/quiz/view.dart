import 'package:cinefouine/core/widgets/cineFouineBoutton.dart';
import 'package:cinefouine/core/widgets/cineFouineHugeBoutton.dart';
import 'package:cinefouine/modules/detailsMovie/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

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

  final Map<String, dynamic> _quizData = {
    "titre_du_quizz": "Quizz sur le film Inception",
    "description_du_quizz": "Testez vos connaissances sur le film 'Inception' de Christopher Nolan. Répondez aux questions suivantes pour voir si vous êtes un véritable expert de ce chef-d'œuvre cinématographique.",
    "liste_de_questions": [
      {
        "texte_de_la_question": "Qui est le réalisateur du film 'Inception' ?",
        "liste_des_options_de_reponse": [
          "Steven Spielberg Spielberg Spielberg ",
          "Christopher Nolan",
          "Quentin Tarantino",
          "Martin Scorsese"
        ],
        "reponse_correcte": "Christopher Nolan"
      },
      {
        "texte_de_la_question": "Quel est le nom du personnage principal joué par Leonardo DiCaprio ?",
        "liste_des_options_de_reponse": [
          "Dom Cobb",
          "Arthur",
          "Ariadne",
          "Saito"
        ],
        "reponse_correcte": "Dom Cobb"
      }
    ]
  };

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
  Widget build(BuildContext context) {
    final currentQuestion = _quizData['liste_de_questions'][_currentQuestionIndex];
    final quizTitle = _quizData['titre_du_quizz'];
    final quizDescription = _quizData['description_du_quizz'];
    final movieSelected = ref.watch(movieSeletedProvider);

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
                if (movieSelected.value?.details?.posterPath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movieSelected.value?.details?.posterPath}',
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            // Ajout de l'indicateur "x/n" centré
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
              currentQuestion['texte_de_la_question'],
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: currentQuestion['liste_des_options_de_reponse'].map<Widget>((option) {
                final isSelected = option == _selectedAnswer;
                final isCorrect = option == currentQuestion['reponse_correcte'];
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
              }).toList(),
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
                    : "Terminer",
                buttonColor: const Color(0xFF1ABC9C),
              ),
          ],
        ),
      ),
    );
  }
}
