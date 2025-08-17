import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'difficulte_screen.dart';
import 'accueil_screen.dart';

class AfterGameScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;
  final String difficulty;
  
  const AfterGameScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.difficulty,
  });

  @override
  State<AfterGameScreen> createState() => _AfterGameScreenState();
}

class _AfterGameScreenState extends State<AfterGameScreen>
    with TickerProviderStateMixin {
  late AnimationController _scoreController;
  late AnimationController _celebrateController;
  late Animation<double> _scoreAnimation;
  late Animation<double> _celebrateAnimation;
  
  double percentage = 0.0;
  String message = '';
  Color messageColor = Colors.white;
  bool isHighScore = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _calculateResults();
    _checkHighScore();
  }

  void _initializeAnimations() {
    _scoreController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _celebrateController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
      vsync: this,
    );
    
    _scoreAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scoreController,
      curve: Curves.elasticOut,
    ));
    
    _celebrateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _celebrateController,
      curve: Curves.bounceOut,
    ));
    
    _scoreController.forward();
    _celebrateController.forward();
  }

  void _calculateResults() {
    percentage = (widget.score / widget.totalQuestions) * 100;
    
    if (percentage >= 80) {
      message = 'Excellent ! Vous êtes un expert !';
      messageColor = const Color(0xFF10B981);
    } else if (percentage >= 60) {
      message = 'Bien joué ! Continuez comme ça !';
      messageColor = const Color(0xFFFF6B35);
    } else if (percentage >= 40) {
      message = 'Pas mal ! Encore un peu d\'effort !';
      messageColor = const Color(0xFFFFA500);
    } else {
      message = 'Ne vous découragez pas ! Continuez à apprendre !';
      messageColor = const Color(0xFFEF4444);
    }
  }

  Future<void> _checkHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'highscore_${widget.difficulty}';
    final currentHighScore = prefs.getInt(key) ?? 0;
    
    if (widget.score > currentHighScore) {
      setState(() {
        isHighScore = true;
      });
      await prefs.setInt(key, widget.score);
      HapticFeedback.heavyImpact();
    }
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _celebrateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccueilScreen(),
                        ),
                        (route) => false,
                      ),
                      icon: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'FIN DE PARTIE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Message de félicitations
              if (isHighScore)
                ScaleTransition(
                  scale: _celebrateAnimation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD700).withOpacity(0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.emoji_events,
                          color: Color(0xFF1E3A8A),
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'NOUVEAU RECORD !',
                          style: TextStyle(
                            color: Color(0xFF1E3A8A),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              
              const SizedBox(height: 30),
              
              // Score principal
              AnimatedBuilder(
                animation: _scoreAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scoreAnimation.value,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.score}',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF6B35),
                              ),
                            ),
                            Text(
                              '/ ${widget.totalQuestions}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 30),
              
              // Pourcentage et message
              Text(
                '${percentage.toInt()}%',
                style: TextStyle(
                  color: messageColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 15),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  message,
                  style: TextStyle(
                    color: messageColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const Spacer(),
              
              // Boutons d'action
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    _buildActionButton(
                      context,
                      'REJOUER',
                      Icons.replay,
                      const Color(0xFFFF6B35),
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DifficulteScreen(),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    _buildActionButton(
                      context,
                      'ACCUEIL',
                      Icons.home,
                      const Color(0xFF10B981),
                      () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccueilScreen(),
                        ),
                        (route) => false,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 15),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
