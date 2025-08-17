class Question {
  final String question;
  final List<String> answers;
  final int correctAnswer;
  final String? explanation;

  const Question({
    required this.question,
    required this.answers,
    required this.correctAnswer,
    this.explanation,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] ?? '',
      answers: List<String>.from(map['answers'] ?? []),
      correctAnswer: map['correct'] ?? 0,
      explanation: map['explanation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answers': answers,
      'correct': correctAnswer,
      'explanation': explanation,
    };
  }
}

class QuestionBank {
  static const Map<String, List<Question>> questions = {
    'facile': [
      Question(
        question: 'Quelle est la capitale de la France ?',
        answers: ['Paris', 'Londres', 'Berlin', 'Madrid'],
        correctAnswer: 0,
        explanation: 'Paris est la capitale de la France depuis le 12ème siècle.',
      ),
      Question(
        question: 'Combien de planètes dans notre système solaire ?',
        answers: ['7', '8', '9', '10'],
        correctAnswer: 1,
        explanation: 'Il y a 8 planètes : Mercure, Vénus, Terre, Mars, Jupiter, Saturne, Uranus et Neptune.',
      ),
      Question(
        question: 'Quel est le plus grand océan du monde ?',
        answers: ['Atlantique', 'Indien', 'Arctique', 'Pacifique'],
        correctAnswer: 3,
        explanation: 'L\'océan Pacifique couvre environ 30% de la surface de la Terre.',
      ),
      Question(
        question: 'En quelle année a eu lieu la Révolution française ?',
        answers: ['1789', '1799', '1769', '1779'],
        correctAnswer: 0,
        explanation: 'La prise de la Bastille a eu lieu le 14 juillet 1789.',
      ),
      Question(
        question: 'Quel est le symbole chimique de l\'or ?',
        answers: ['Ag', 'Au', 'Fe', 'Cu'],
        correctAnswer: 1,
        explanation: 'Au vient du latin "aurum" qui signifie or.',
      ),
      Question(
        question: 'Quel animal est le plus rapide du monde ?',
        answers: ['Guépard', 'Faucon pèlerin', 'Antilope', 'Lion'],
        correctAnswer: 1,
        explanation: 'Le faucon pèlerin peut atteindre 389 km/h en piqué.',
      ),
      Question(
        question: 'Combien de couleurs y a-t-il dans un arc-en-ciel ?',
        answers: ['5', '6', '7', '8'],
        correctAnswer: 2,
        explanation: 'Les 7 couleurs sont : rouge, orange, jaune, vert, bleu, indigo et violet.',
      ),
    ],
    'moyen': [
      Question(
        question: 'Quel est le plus grand désert du monde ?',
        answers: ['Sahara', 'Antarctique', 'Gobi', 'Kalahari'],
        correctAnswer: 1,
        explanation: 'L\'Antarctique est le plus grand désert avec 14 millions de km².',
      ),
      Question(
        question: 'Qui a peint la Joconde ?',
        answers: ['Van Gogh', 'Michel-Ange', 'Léonard de Vinci', 'Raphaël'],
        correctAnswer: 2,
        explanation: 'Léonard de Vinci a peint ce chef-d\'œuvre entre 1503 et 1519.',
      ),
      Question(
        question: 'Quel est le nom de la plus haute montagne du monde ?',
        answers: ['K2', 'Mont Blanc', 'Everest', 'Kilimandjaro'],
        correctAnswer: 2,
        explanation: 'L\'Everest culmine à 8 848 mètres d\'altitude.',
      ),
      Question(
        question: 'Combien d\'os y a-t-il dans le corps humain adulte ?',
        answers: ['156', '206', '256', '306'],
        correctAnswer: 1,
        explanation: 'Un adulte a 206 os, un nouveau-né en a environ 300.',
      ),
      Question(
        question: 'Quel est le plus grand pays du monde par superficie ?',
        answers: ['Chine', 'États-Unis', 'Canada', 'Russie'],
        correctAnswer: 3,
        explanation: 'La Russie couvre 17 millions de km², soit 11% des terres émergées.',
      ),
      Question(
        question: 'Quel est le nom de la plus grande forêt du monde ?',
        answers: ['Forêt amazonienne', 'Taïga sibérienne', 'Forêt du Congo', 'Forêt boréale'],
        correctAnswer: 1,
        explanation: 'La taïga sibérienne couvre 5,7 millions de km².',
      ),
      Question(
        question: 'En quelle année a été créé le premier iPhone ?',
        answers: ['2005', '2007', '2009', '2011'],
        correctAnswer: 1,
        explanation: 'Steve Jobs a présenté le premier iPhone en 2007.',
      ),
    ],
    'difficile': [
      Question(
        question: 'Quel est le nom du processus par lequel les plantes produisent leur nourriture ?',
        answers: ['Respiration', 'Photosynthèse', 'Fermentation', 'Digestion'],
        correctAnswer: 1,
        explanation: 'La photosynthèse convertit la lumière solaire en énergie chimique.',
      ),
      Question(
        question: 'En quelle année a été découverte la structure de l\'ADN ?',
        answers: ['1953', '1963', '1943', '1973'],
        correctAnswer: 0,
        explanation: 'Watson et Crick ont publié leur découverte en 1953.',
      ),
      Question(
        question: 'Quel est le nom de la théorie qui explique l\'origine de l\'univers ?',
        answers: ['Théorie des cordes', 'Big Bang', 'Multivers', 'Relativité'],
        correctAnswer: 1,
        explanation: 'La théorie du Big Bang a été proposée par Georges Lemaître en 1927.',
      ),
      Question(
        question: 'Combien de chromosomes possède l\'être humain ?',
        answers: ['23 paires', '24 paires', '22 paires', '25 paires'],
        correctAnswer: 0,
        explanation: 'L\'humain a 23 paires de chromosomes, soit 46 au total.',
      ),
      Question(
        question: 'Quel est le nom du plus petit nombre premier ?',
        answers: ['0', '1', '2', '3'],
        correctAnswer: 2,
        explanation: '2 est le seul nombre premier pair et le plus petit.',
      ),
      Question(
        question: 'Quel est le nom de la particule élémentaire découverte en 2012 ?',
        answers: ['Boson de Higgs', 'Quark', 'Neutrino', 'Électron'],
        correctAnswer: 0,
        explanation: 'Le boson de Higgs confirme l\'existence du champ de Higgs.',
      ),
      Question(
        question: 'Quel est le nom du mathématicien qui a prouvé le dernier théorème de Fermat ?',
        answers: ['Andrew Wiles', 'Grigori Perelman', 'Edward Witten', 'Terence Tao'],
        correctAnswer: 0,
        explanation: 'Andrew Wiles a publié sa preuve en 1995 après 7 ans de travail.',
      ),
    ],
  };

  static List<Question> getQuestionsForDifficulty(String difficulty) {
    return questions[difficulty] ?? [];
  }

  static int getQuestionCount(String difficulty) {
    return questions[difficulty]?.length ?? 0;
  }
}
