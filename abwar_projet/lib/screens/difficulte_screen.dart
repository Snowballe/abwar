import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_screen.dart';

class DifficulteScreen extends StatelessWidget {
  final List<String> players;
  
  const DifficulteScreen({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         decoration: const BoxDecoration(
           image: DecorationImage(
             image: AssetImage('assets/images/iceberg.jpg'),
             fit: BoxFit.cover,
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
                          'SÉLECTIONNER LA DIFFICULTÉ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 50), // Pour centrer le titre
                  ],
                ),
              ),
              
             
              const SizedBox(height: 30),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Boutons de difficulté
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                                                         _buildDifficultyButton(
                               context,
                               'On vient de commencer la soirée, tout va bien, on boit les premières bières !',
                               '1 à 3 gorgées.',
                               'assets/images/diff1.png',
                               const Color(0xFF10B981).withValues(alpha: 0.25),
                               () => _startGame(context, 'facile'),
                             ),
                            
                            const SizedBox(height: 25),
                            
                                                         _buildDifficultyButton(
                               context,
                               'On commence à être entamés, on passe à l\'alcool fort.',
                               '1 à 6 gorgées.',
                               'assets/images/diff2.png',
                               const Color(0xFFFF6B35).withValues(alpha: 0.25),
                               () => _startGame(context, 'moyen'),
                             ),
                            
                            const SizedBox(height: 25),
                            
                                                         _buildDifficultyButton(
                               context,
                               'Il est 5h du matin. Pourquoi je lance ce jeu déjà ?',
                               '1 à 9 gorgées.',
                               'assets/images/diff3.png',
                               const Color(0xFFEF4444).withValues(alpha: 0.25),
                               () => _startGame(context, 'difficile'),
                             ),
                          ],
                        ),
                      ),  
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(
    BuildContext context,
    String title,
    String subtitle,
    String imagePath,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 80,
        maxHeight: 170,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
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
        child: GestureDetector(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// ✅ Image prend toute la hauteur du container
                SizedBox(
                  width: 120,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  ),
                ),
              
                const SizedBox(width: 15),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startGame(BuildContext context, String difficulty) {
    // Haptic feedback
    HapticFeedback.lightImpact();
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(
          difficulty: difficulty,
          players: players,
        ),
      ),
    );
  }
}
