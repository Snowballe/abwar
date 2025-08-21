import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'after_game_screen.dart';
import '../models/question.dart';

class GameScreen extends StatefulWidget {
  final String difficulty;
  
  const GameScreen({super.key, required this.difficulty});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late AnimationController _timerController;
  late AnimationController _questionController;
  late Animation<double> _timerAnimation;
  late Animation<double> _questionAnimation;
  
  int currentQuestionIndex = 0;
  int score = 0;
  int timeLeft = 30;
  bool isGameActive = true;
  String? selectedAnswer;
  bool showResult = false;
  
  // Questions par difficulté
  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    questions = QuestionBank.getQuestionsForDifficulty(widget.difficulty);
    _initializeAnimations();
    _startTimer();
  }

  void _initializeAnimations() {
    _timerController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );
    
    _questionController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _timerAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _timerController,
      curve: Curves.linear,
    ));
    
    _questionAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _questionController,
      curve: Curves.easeInOut,
    ));
    
    _questionController.forward();
  }

  void _startTimer() {
    _timerController.forward();
    
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted && isGameActive) {
        _endGame();
      }
    });
  }

  void _selectAnswer(int answerIndex) {
    if (!isGameActive || selectedAnswer != null) return;
    
    setState(() {
      selectedAnswer = answerIndex.toString();
      showResult = true;
    });
    
    HapticFeedback.mediumImpact();
    
    // Vérifier la réponse
    final currentQuestion = questions[currentQuestionIndex];
    if (answerIndex == currentQuestion.correctAnswer) {
      score++;
    }
    
    // Attendre un peu puis passer à la question suivante
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        showResult = false;
      });
      
      _questionController.reset();
      _questionController.forward();
    } else {
      _endGame();
    }
  }

  void _endGame() {
    setState(() {
      isGameActive = false;
    });
    
    _timerController.stop();
    
    // Naviguer vers l'écran de fin de partie
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AfterGameScreen(
          score: score,
          totalQuestions: questions.length,
          difficulty: widget.difficulty,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timerController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A),
              Color(0xFF3B82F6),
              Color(0xFF60A5FA),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header avec score et timer
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => _showExitDialog(context),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                                                  Text(
                          'Question ${currentQuestionIndex + 1}/${questions.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                          const SizedBox(height: 5),
                          Text(
                            'Score: $score',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Timer circulaire
                    Container(
                      width: 60,
                      height: 60,
                      child: AnimatedBuilder(
                        animation: _timerAnimation,
                        builder: (context, child) {
                          return CircularProgressIndicator(
                            value: _timerAnimation.value,
                            strokeWidth: 6,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Question
              FadeTransition(
                opacity: _questionAnimation,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Text(
                    currentQuestion.question,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Réponses
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: List.generate(
                    currentQuestion.answers.length,
                    (index) => _buildAnswerButton(
                      context,
                      currentQuestion.answers[index],
                      index,
                      currentQuestion.correctAnswer,
                    ),
                  ),
                ),
              ),
              
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerButton(
    BuildContext context,
    String answer,
    int index,
    int correctAnswer,
  ) {
    final isSelected = selectedAnswer == index.toString();
    final isCorrect = index == correctAnswer;
    final showCorrectAnswer = showResult && isCorrect;
    
    Color buttonColor = Colors.white;
    Color textColor = const Color(0xFF1E3A8A);
    
    if (showResult) {
      if (isSelected && isCorrect) {
        buttonColor = const Color(0xFF10B981);
        textColor = Colors.white;
      } else if (isSelected && !isCorrect) {
        buttonColor = const Color(0xFFEF4444);
        textColor = Colors.white;
      } else if (showCorrectAnswer) {
        buttonColor = const Color(0xFF10B981);
        textColor = Colors.white;
      }
    }
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => _selectAnswer(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: buttonColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: textColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index), // A, B, C, D
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    answer,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (showResult)
                  Icon(
                    isSelected && isCorrect
                        ? Icons.check_circle
                        : isSelected && !isCorrect
                            ? Icons.cancel
                            : showCorrectAnswer
                                ? Icons.check_circle
                                : null,
                    color: textColor,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Quitter la partie ?',
            style: TextStyle(
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Êtes-vous sûr de vouloir quitter ? Votre progression sera perdue.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Continuer',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Quitter',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
