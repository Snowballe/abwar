import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'difficulte_screen.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({super.key});

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  final List<TextEditingController> _nameControllers = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialiser 4 champs de base comme dans AccueilActivity.java
    for (int i = 0; i < 4; i++) {
      _nameControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addNewTextField() {
    setState(() {
      _nameControllers.add(TextEditingController());
    });
  }

  List<String> _getValidNames() {
    List<String> validNames = [];
    for (var controller in _nameControllers) {
      String name = controller.text.trim();
      if (name.isNotEmpty) {
        validNames.add(name);
      }
    }
    return validNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
             body: Container(
         decoration: const BoxDecoration(
           color: Color(0xFF00CC83),
         ),
         child: Stack(
          children: [
            // Contenu principal avec padding
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                                         // Logo ABWAR
                     Container(
                       width: 170,
                       height: 170,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.2),
                             blurRadius: 30,
                             offset: const Offset(0, 20),
                           ),
                         ],
                       ),
                          child: ClipOval(
                          child: Image.asset(
                            'assets/images/logo_abwar.png',
                            width: 120,
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                     ),
                    
                    const SizedBox(height: 20),
                    
                                         // ScrollView avec les champs de prénoms
                     Container(
                       height: MediaQuery.of(context).size.height * 0.5, // Hauteur fixe à 50% de l'écran
                       child: Container(
                         padding: const EdgeInsets.all(20),
                         decoration: BoxDecoration(
                           color: Colors.white.withOpacity(0.1),
                           borderRadius: BorderRadius.circular(10),
                           border: Border.all(color: Colors.white.withOpacity(0.2)),
                         ),
                         child: Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text(
                                   'Joueurs (${_nameControllers.length})',
                                   style: const TextStyle(
                                     color: Colors.white,
                                     fontSize: 18,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 Container(
                                   decoration: BoxDecoration(
                                     color: const Color(0xFFFF6B35),
                                     borderRadius: BorderRadius.circular(15),
                                   ),
                                   child: IconButton(
                                     onPressed: _addNewTextField,
                                     icon: const Icon(Icons.add, color: Colors.white),
                                     tooltip: 'Ajouter un joueur',
                                   ),
                                 ),
                               ],
                             ),
                             const SizedBox(height: 15),
                             Expanded(
                               child: Form(
                                 key: _formKey,
                                 child: ListView.builder(
                                   itemCount: _nameControllers.length,
                                   itemBuilder: (context, index) {
                                     return Container(
                                       margin: const EdgeInsets.only(bottom: 15),
                                       child: TextFormField(
                                         controller: _nameControllers[index],
                                         style: const TextStyle(
                                           color: Colors.white,
                                           fontSize: 16,
                                         ),
                                         decoration: InputDecoration(
                                           hintText: 'Joueur N°${index + 1}',
                                           hintStyle: TextStyle(
                                             color: Colors.white.withOpacity(0.7),
                                           ),
                                           border: OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(15),
                                             borderSide: BorderSide(
                                               color: Colors.white.withOpacity(0.3),
                                             ),
                                           ),
                                           enabledBorder: OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(15),
                                             borderSide: BorderSide(
                                               color: Colors.white.withOpacity(0.3),
                                             ),
                                           ),
                                           focusedBorder: OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(15),
                                             borderSide: const BorderSide(color: Colors.white),
                                           ),
                                           filled: true,
                                           fillColor: Colors.white.withOpacity(0.1),
                                         ),
                                         inputFormatters: [
                                           FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ÿ\s]')),
                                           LengthLimitingTextInputFormatter(16),
                                         ],
                                         textCapitalization: TextCapitalization.words,
                                         validator: (value) {
                                           // Validation optionnelle - on peut laisser vide
                                           return null;
                                         },
                                       ),
                                     );
                                   },
                                 ),
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
            
            // Boutons positionnés en bas (seront cachés par le clavier)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  // Bouton Jouer
                  _buildButton(
                    context,
                    'C\'EST TARPI !',
                    Icons.play_arrow,
                    const Color(0xFFFF6B35),
                    () {
                      List<String> validNames = _getValidNames();
                      if (validNames.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DifficulteScreen(players: validNames),
                          ),
                        );
                      }
                    },
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // Bouton Quitter
                  _buildButton(
                    context,
                    'QUITTER',
                    Icons.exit_to_app,
                    const Color(0xFFEF4444),
                    () => _showExitDialog(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      width: 250,
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
            'Quitter ABWAR ?',
            style: TextStyle(
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Êtes-vous sûr de vouloir quitter l\'application ?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Annuler',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Fermer l'application
                SystemNavigator.pop();
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
