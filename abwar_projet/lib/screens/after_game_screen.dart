import 'package:flutter/material.dart';
import 'accueil_screen.dart';

class AfterGameScreen extends StatefulWidget {
  final List<String> players;
  final Map<String, int> scores;
  final String difficulty;
  
  const AfterGameScreen({
    super.key,
    required this.players,
    required this.scores,
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
  
  String message = '';
  Color messageColor = Colors.white;
  String winner = '';
  int maxScore = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _calculateResults();
  }

  void _initializeAnimations() {
    _scoreController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _celebrateController = AnimationController(
      duration: const Duration(milliseconds: 800),
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
    // Trouver le gagnant (celui avec le plus de gorgées)
    maxScore = 0;
    for (String player in widget.players) {
      int score = widget.scores[player] ?? 0;
      if (score > maxScore) {
        maxScore = score;
        winner = player;
      }
    }
    
    // Définir le message selon la difficulté
    switch (widget.difficulty) {
      case 'facile':
        message = 'Soirée tranquille terminée !';
        messageColor = const Color(0xFF10B981);
        break;
      case 'moyen':
        message = 'Soirée bien arrosée !';
        messageColor = const Color(0xFFFF6B35);
        break;
      case 'difficile':
        message = 'Soirée de folie terminée !';
        messageColor = const Color(0xFFEF4444);
        break;
      default:
        message = 'Partie terminée !';
        messageColor = const Color(0xFF10B981);
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
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
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
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Message de fin
              FadeTransition(
                opacity: _celebrateAnimation,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: messageColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: messageColor,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: messageColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Gagnant
              if (winner.isNotEmpty)
                FadeTransition(
                  opacity: _scoreAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.amber,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.emoji_events,
                          color: Colors.amber,
                          size: 50,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '🏆 GAGNANT 🏆',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$winner avec $maxScore gorgées !',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              
              const SizedBox(height: 30),
              
              // Classement des joueurs
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'CLASSEMENT FINAL',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: widget.players.length,
                          itemBuilder: (context, index) {
                            // Trier les joueurs par score décroissant
                            List<MapEntry<String, int>> sortedScores = 
                                widget.scores.entries.toList()
                                  ..sort((a, b) => b.value.compareTo(a.value));
                            
                            String playerName = sortedScores[index].key;
                            int score = sortedScores[index].value;
                            
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: index == 0 
                                    ? Colors.amber.withOpacity(0.2)
                                    : Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: index == 0 
                                      ? Colors.amber 
                                      : Colors.white.withOpacity(0.3),
                                  width: index == 0 ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Position
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: index == 0 
                                          ? Colors.amber 
                                          : Colors.white.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          color: index == 0 
                                              ? Colors.black 
                                              : Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  // Nom du joueur
                                  Expanded(
                                    child: Text(
                                      playerName,
                                      style: TextStyle(
                                        color: index == 0 
                                            ? Colors.amber 
                                            : Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // Score
                                  Text(
                                    '$score gorgées',
                                    style: TextStyle(
                                      color: index == 0 
                                          ? Colors.amber 
                                          : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
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
                      () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccueilScreen(),
                        ),
                        (route) => false,
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
