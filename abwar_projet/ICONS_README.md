# Gestion des Icônes de l'Application

## Icône Actuelle
L'application utilise actuellement l'icône `assets/images/icone_abwar.png` comme icône principale.

## Comment Changer l'Icône

### 1. Préparer la Nouvelle Image
- Placez votre nouvelle image dans le dossier `assets/images/`
- L'image doit être au format PNG
- Recommandé : 1024x1024 pixels pour une qualité optimale
- Évitez les images avec canal alpha pour iOS

### 2. Installer flutter_launcher_icons
```bash
flutter pub add --dev flutter_launcher_icons
```

### 3. Modifier la Configuration
Éditez le fichier `flutter_launcher_icons.yaml` et changez le chemin de l'image :
```yaml
image_path: "assets/images/votre_nouvelle_icone.png"
```

### 4. Générer les Nouvelles Icônes
```bash
flutter pub run flutter_launcher_icons:main
```

### 5. Nettoyer
Supprimez la dépendance après génération :
```bash
flutter pub remove flutter_launcher_icons
```

## Plateformes Supportées
- ✅ Android (toutes les résolutions)
- ✅ iOS (toutes les tailles)
- ✅ Web (favicon et PWA)
- ✅ Windows
- ✅ macOS

## Notes Importantes
- Pour iOS : `remove_alpha_ios: true` supprime automatiquement le canal alpha
- Les couleurs web utilisent les couleurs de votre thème d'application
- Les icônes sont générées dans les dossiers appropriés de chaque plateforme
