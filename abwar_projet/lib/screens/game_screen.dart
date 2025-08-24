import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'after_game_screen.dart';

class GameScreen extends StatefulWidget {
  final String difficulty;
  final List<String> players;
  
  const GameScreen({super.key, required this.difficulty, required this.players});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String currentQuestion = "Est-ce que tout le monde est prêt ?";
  List<Map<String, dynamic>> questions = [];
  List<int> usedQuestionIndexes = [];
  List<int> usedPlayerIndexes = [];
  int questionCount = 0;
  int maxQuestions = 50;
  
  // Gestion des difficultés
  late int minGulps;
  late int maxGulps;
  
  // Couleurs de fond
  final List<Color> backgroundColors = [
    const Color(0xFFE88986), // Rose
    const Color(0xFF00CC83), // Vert
    const Color(0xFF55868C), // Bleu-gris
    const Color(0xFF022B3A), // Bleu foncé
  ];
  
  Color currentBackgroundColor = Colors.black;
  Color currentTextColor = Colors.white;
  
  // Scores des joueurs
  Map<String, int> playerScores = {};
  
  @override
  void initState() {
    super.initState();
    _initializeGame();
    _loadQuestions();
  }
  
  void _initializeGame() {
    // Initialiser les scores des joueurs
    for (String player in widget.players) {
      playerScores[player] = 0;
    }
    
    // Définir les gorgées selon la difficulté
    switch (widget.difficulty) {
      case 'facile':
        minGulps = 1;
        maxGulps = 3;
        break;
      case 'moyen':
        minGulps = 1;
        maxGulps = 6;
        break;
      case 'difficile':
        minGulps = 1;
        maxGulps = 9;
        break;
      default:
        minGulps = 1;
        maxGulps = 3;
    }
    
    // Forcer l'orientation paysage
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  
  Future<void> _loadQuestions() async {
    try {
      final String jsonString = await DefaultAssetBundle.of(context).loadString('assets/questions.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      setState(() {
        questions = jsonList.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Erreur lors du chargement des questions: $e');
    }
  }
  
  void _nextQuestion() {
    if (questionCount >= maxQuestions) {
      _endGame();
      return;
    }
    
    if (questions.isEmpty) return;
    
    // Sélectionner une question aléatoire non utilisée
    int randomQuestionIndex;
    do {
      randomQuestionIndex = Random().nextInt(questions.length);
    } while (usedQuestionIndexes.contains(randomQuestionIndex));
    
    // Récupérer la question
    String question = questions[randomQuestionIndex]['question'];
    
    // Traitement des tags %plr% (joueurs) - logique inspirée du code Java
    List<String> questionParts = question.split('%plr%');
    StringBuffer processedQuestion = StringBuffer();
    
         // Vérifier qu'on a assez de joueurs pour cette question
     if (questionParts.length > widget.players.length + 1) {
       // Question trop complexe, on en prend une autre
       // Éviter la récursion infinie en prenant une question plus simple
       if (questionCount < maxQuestions - 1) {
         _nextQuestion();
       }
       return;
     }
    
    // Traiter chaque partie de la question avec un joueur différent
    for (int i = 0; i < questionParts.length - 1; i++) {
      // Sélectionner un joueur aléatoire non utilisé pour cette question
      int randomPlayerIndex;
      do {
        randomPlayerIndex = Random().nextInt(widget.players.length);
      } while (usedPlayerIndexes.contains(randomPlayerIndex));
      
      // Ajouter la partie de la question + le nom du joueur
      processedQuestion.write(questionParts[i] + widget.players[randomPlayerIndex]);
      
      // Marquer ce joueur comme utilisé pour cette question
      usedPlayerIndexes.add(randomPlayerIndex);
    }
    
         // Ajouter la dernière partie de la question (avec vérification de sécurité)
     if (questionParts.isNotEmpty) {
       processedQuestion.write(questionParts.last);
     }
    
    // Traitement des tags %gog% (gorgées)
    question = processedQuestion.toString();
    List<String> gulpParts = question.split('%gog%');
    processedQuestion.clear();
    
    // Sélectionner un nombre aléatoire de gorgées
    int randomGulps = Random().nextInt(maxGulps - minGulps + 1) + minGulps;
    
    // Traiter chaque partie de la question avec le nombre de gorgées
    for (int i = 0; i < gulpParts.length - 1; i++) {
      processedQuestion.write(gulpParts[i] + randomGulps.toString());
    }
    
         // Ajouter la dernière partie (avec vérification de sécurité)
     if (gulpParts.isNotEmpty) {
       processedQuestion.write(gulpParts.last);
     }
    
    // Changer la couleur de fond
    Color newBackgroundColor = backgroundColors[Random().nextInt(backgroundColors.length)];
    
    setState(() {
      currentQuestion = processedQuestion.toString();
      currentBackgroundColor = newBackgroundColor;
      currentTextColor = Colors.white;
      usedQuestionIndexes.add(randomQuestionIndex);
      questionCount++;
    });
    
    // Réinitialiser la liste des joueurs utilisés pour la prochaine question
    if (questionCount % 3 == 0) {
      usedPlayerIndexes.clear();
    }
  }
  
  void _endGame() {
    // Restaurer l'orientation normale
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AfterGameScreen(
          players: widget.players,
          scores: playerScores,
          difficulty: widget.difficulty,
        ),
      ),
    );
  }
  
  void _updatePlayerScore(String playerName, int delta) {
    setState(() {
      playerScores[playerName] = (playerScores[playerName] ?? 0) + delta;
      if (playerScores[playerName]! < 0) {
        playerScores[playerName] = 0;
      }
    });
  }
  
  @override
  void dispose() {
    // Restaurer l'orientation normale
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: currentBackgroundColor,
            child: SafeArea(
              child: Row(
                children: [
                  // Zone de jeu principale (gauche)
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                                                 // Header
                         Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               // Logo ABWAR
                               Container(
                                 width: 100,
                                 height: 40,
                                 child: ClipRRect(
                                   child: Image.asset(
                                     'assets/images/abwar_titre.png',
                                     width: 65,
                                     height: 65,
                                     fit: BoxFit.contain,
                                   ),
                                 ),
                               ),
                               // Bouton Quitter
                               IconButton(
                                 onPressed: () => _showExitDialog(context),
                                 icon: Icon(
                                   Icons.close,
                                   color: currentTextColor,
                                   size: 20,
                                 ),
                               ),
                             ],
                           ),
                         ),
                        
                        
                        // Question
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          
                          child: Text(
                            currentQuestion,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: currentTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                        const Spacer(),
                      ],
                    ),
                  ),
                  
                                     // Scoreboard des joueurs (droite)
                   Container(
                     width: MediaQuery.of(context).size.width * 0.25, // 25% de la largeur de l'écran
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        border: Border(
                          left: BorderSide(
                            color: currentTextColor.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'SCORES',
                            style: TextStyle(
                              color: currentTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.players.length,
                              itemBuilder: (context, index) {
                                String playerName = widget.players[index];
                                int score = playerScores[playerName] ?? 0;
                                
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: currentTextColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: currentTextColor.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '$playerName : $score',
                                        style: TextStyle(
                                          color: currentTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                                                             Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: [
                                           ElevatedButton(
                                             onPressed: () => _updatePlayerScore(playerName, -1),
                                             style: ElevatedButton.styleFrom(
                                               backgroundColor: Colors.red,
                                               foregroundColor: Colors.white,
                                               minimumSize: const Size(35, 35),
                                               shape: const CircleBorder(),
                                             ),
                                             child: const Text('-', style: TextStyle(fontSize: 14)),
                                           ),
                                           ElevatedButton(
                                             onPressed: () => _updatePlayerScore(playerName, 1),
                                             style: ElevatedButton.styleFrom(
                                               backgroundColor: Colors.green,
                                               foregroundColor: Colors.white,
                                               minimumSize: const Size(35, 35),
                                               shape: const CircleBorder(),
                                             ),
                                             child: const Text('+', style: TextStyle(fontSize: 14)),
                                           ),
                                         ],
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
                ],
              ),
            ),
          ),
          
          // Bouton NEXT sticky en bas
          Positioned(
            bottom: 20,
            left: 20, // Marge de 20px depuis la gauche
            right: MediaQuery.of(context).size.width * 0.25 + 20, // Largeur du scoreboard + marge
            child: Container(
              height: 50,
              child: ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentTextColor,
                  foregroundColor: currentBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 8,
                ),
                child: const Text(
                  'NEXT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
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
            'Quitter la partie en cours ?',
            style: TextStyle(
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Tu deviens gay si tu quittes la partie en cours.\n(c\'est pas moi qui le dit c\'est écrit dans mon livre)',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF1E3A8A),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Laissez-moi boire par pitié',
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
                'J\'me tire !',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
