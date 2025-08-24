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
                     color: Color(0xFF00CC83),
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
                          'C\'EST FINI !',
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
              
              
              // Gagnant
              if (winner.isNotEmpty)
                FadeTransition(
                  opacity: _scoreAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.amber,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        
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
                        const SizedBox(height: 5),
                        Text(
                          'Venges-toi et distribues ${(maxScore*0.2).ceil()} gorgées !',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 14,
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
                                color: _getBackgroundColor(index),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: _getBorderColor(index),
                                  width: index < 3 ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Position
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: _getPositionColor(index),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: _getPositionIcon(index),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  // Nom du joueur
                                  Expanded(
                                    child: Text(
                                      playerName,
                                      style: TextStyle(
                                        color: _getTextColor(index),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // Score
                                  Text(
                                    '$score gorgées bues \n${(score*0.2).ceil()} à distribuer',
                                    style: TextStyle(
                                      color: _getTextColor(index),
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
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Méthodes helper pour les couleurs du top 3
  Color _getBackgroundColor(int index) {
    switch (index) {
      case 0: // Or
        return Colors.amber.withOpacity(0.2);
      case 1: // Argent
        return Colors.grey.withOpacity(0.2);
      case 2: // Bronze
        return const Color(0xFFCD7F32).withOpacity(0.2); // Couleur bronze
      default:
        return Colors.white.withOpacity(0.1);
    }
  }

  Color _getBorderColor(int index) {
    switch (index) {
      case 0: // Or
        return Colors.amber;
      case 1: // Argent
        return Colors.grey;
      case 2: // Bronze
        return const Color(0xFFCD7F32); // Couleur bronze
      default:
        return Colors.white.withOpacity(0.3);
    }
  }

  Color _getPositionColor(int index) {
    switch (index) {
      case 0: // Or
        return Colors.amber;
      case 1: // Argent
        return Colors.grey;
      case 2: // Bronze
        return const Color(0xFFCD7F32); // Couleur bronze
      default:
        return Colors.white.withOpacity(0.3);
    }
  }

  Color _getPositionTextColor(int index) {
    switch (index) {
      case 0: // Or
        return Colors.black;
      case 1: // Argent
        return Colors.white;
      case 2: // Bronze
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  Widget _getPositionIcon(int index) {
    switch (index) {
      case 0: // 🥇 1er - Trophée
        return const Icon(
          Icons.emoji_events,
          color: Colors.black,
          size: 24,
        );
      case 1: // 🥈 2ème - Médaille
        return const Icon(
          Icons.military_tech,
          color: Colors.white,
          size: 24,
        );
      case 2: // 🥉 3ème - Bière
        return const Icon(
          Icons.sports_bar,
          color: Colors.white,
          size: 24,
        );
      default: // 4ème et plus - Numéro
        return Text(
          '${index + 1}',
          style: TextStyle(
            color: _getPositionTextColor(index),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        );
    }
  }

  Color _getTextColor(int index) {
    // Garder le texte en blanc pour tous les joueurs
    return Colors.white;
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
