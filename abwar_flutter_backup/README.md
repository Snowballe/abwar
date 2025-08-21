# ABWAR Flutter

Une application de quiz moderne et interactive développée avec Flutter, refactorisée depuis l'application Android native.

## 🎯 Fonctionnalités

- **3 niveaux de difficulté** : Facile, Moyen, Difficile
- **Système de score** avec sauvegarde des records personnels
- **Interface moderne** avec animations fluides et design Material 3
- **Questions variées** de culture générale
- **Timer de 30 secondes** par question
- **Feedback haptique** pour une meilleure expérience utilisateur
- **Thème adaptatif** (clair/sombre)

## 🚀 Installation et lancement

### Prérequis
- Flutter SDK (version 3.0.0 ou supérieure)
- Android Studio / VS Code avec extensions Flutter
- Un appareil Android connecté ou émulateur

### Étapes d'installation

1. **Cloner le projet**
   ```bash
   cd abwar_flutter
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Lancer l'application**
   ```bash
   flutter run
   ```

### Pour le développement sur téléphone

1. **Activer le mode développeur** sur ton téléphone Android
2. **Activer le débogage USB**
3. **Connecter le téléphone** à ton PC
4. **Lancer** `flutter run` dans le dossier `abwar_flutter`

## 📱 Structure de l'application

### Écrans principaux

- **AccueilScreen** : Page d'accueil avec logo et menu principal
- **DifficulteScreen** : Sélection du niveau de difficulté
- **GameScreen** : Interface de jeu avec questions et timer
- **AfterGameScreen** : Résultats et score final
- **TroisScreen** : Règles du jeu et explications

### Modèles de données

- **Question** : Structure des questions avec réponses et explications
- **QuestionBank** : Banque de questions organisées par difficulté

## 🎮 Comment jouer

1. **Choisir un niveau** de difficulté (Facile, Moyen, Difficile)
2. **Répondre aux questions** en sélectionnant A, B, C ou D
3. **Respecter le timer** de 30 secondes par question
4. **Obtenir le meilleur score** possible
5. **Battre tes records** personnels !

## 🎨 Design et UX

- **Gradients bleus** pour un look moderne et professionnel
- **Animations fluides** avec des transitions élégantes
- **Feedback visuel** immédiat pour les bonnes/mauvaises réponses
- **Interface intuitive** avec navigation claire
- **Responsive design** adapté à tous les écrans

## 🔧 Technologies utilisées

- **Flutter** : Framework de développement cross-platform
- **Dart** : Langage de programmation
- **Material Design 3** : Système de design Google
- **SharedPreferences** : Sauvegarde locale des scores
- **Animations** : Contrôleurs d'animation Flutter

## 📊 Système de scoring

- **1 point** par bonne réponse
- **Pourcentage de réussite** affiché à la fin
- **Records personnels** sauvegardés par niveau
- **Messages d'encouragement** selon la performance

## 🚧 Développement

### Ajouter de nouvelles questions

Modifiez le fichier `lib/models/question.dart` pour ajouter des questions dans la `QuestionBank`.

### Personnaliser l'interface

Les couleurs et styles sont définis dans `lib/main.dart` et dans chaque écran.

### Ajouter de nouvelles fonctionnalités

L'architecture modulaire facilite l'ajout de nouvelles fonctionnalités.

## 📝 Licence

Ce projet est développé pour un usage éducatif et personnel.

## 🤝 Contribution

Les suggestions d'amélioration et contributions sont les bienvenues !

---

**Développé avec ❤️ et Flutter**
