import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TroisScreen extends StatelessWidget {
  const TroisScreen({super.key});

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
              // Header avec bouton retour
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
                          'RÈGLES DU JEU',
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
              
              const SizedBox(height: 20),
              
              // Contenu des règles
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Titre principal
                        const Center(
                          child: Text(
                            'Comment jouer à ABWAR',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E3A8A),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Section 1: Objectif
                        _buildRuleSection(
                          '🎯 Objectif du jeu',
                          'Répondez correctement au maximum de questions dans le temps imparti pour obtenir le meilleur score possible.',
                          Icons.target,
                          const Color(0xFFFF6B35),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Section 2: Déroulement
                        _buildRuleSection(
                          '⏱️ Déroulement d\'une partie',
                          'Chaque question vous donne 30 secondes pour répondre. Choisissez la bonne réponse parmi les 4 propositions (A, B, C, D).',
                          Icons.timer,
                          const Color(0xFF10B981),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Section 3: Niveaux de difficulté
                        _buildRuleSection(
                          '📊 Niveaux de difficulté',
                          '• FACILE : Questions de culture générale basiques\n• MOYEN : Questions plus complexes\n• DIFFICILE : Questions d\'expert',
                          Icons.trending_up,
                          const Color(0xFF8B5CF6),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Section 4: Scoring
                        _buildRuleSection(
                          '🏆 Système de score',
                          'Chaque bonne réponse vous donne 1 point. Votre score final est affiché à la fin de la partie avec un pourcentage de réussite.',
                          Icons.emoji_events,
                          const Color(0xFFFFD700),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Section 5: Conseils
                        _buildRuleSection(
                          '💡 Conseils pour bien jouer',
                          '• Lisez attentivement chaque question\n• Éliminez les réponses évidentes\n• Ne paniquez pas si le temps presse\n• Apprenez de vos erreurs !',
                          Icons.lightbulb,
                          const Color(0xFFF59E0B),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Section 6: Records
                        _buildRuleSection(
                          '📈 Records personnels',
                          'Vos meilleurs scores sont sauvegardés pour chaque niveau de difficulté. Battez vos records !',
                          Icons.leaderboard,
                          const Color(0xFFEF4444),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Bouton "J'ai compris"
                        Center(
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF10B981).withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(25),
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  Navigator.pop(context);
                                },
                                child: const Center(
                                  child: Text(
                                    'J\'AI COMPRIS !',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleSection(
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF374151),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
