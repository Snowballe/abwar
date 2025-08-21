# Guide d'installation Flutter pour ABWAR

## 🚀 Installation de Flutter

### 1. Télécharger Flutter SDK

1. **Aller sur** [flutter.dev](https://flutter.dev/docs/get-started/install/windows)
2. **Télécharger** le SDK Flutter pour Windows
3. **Extraire** le fichier ZIP dans `C:\src\flutter` (ou un autre dossier)

### 2. Ajouter Flutter au PATH

1. **Ouvrir** les Variables d'environnement système
2. **Modifier** la variable PATH
3. **Ajouter** `C:\src\flutter\bin` (ou votre chemin d'installation)

### 3. Vérifier l'installation

```bash
flutter doctor
```

### 4. Installer Android Studio

1. **Télécharger** [Android Studio](https://developer.android.com/studio)
2. **Installer** avec les composants Android SDK
3. **Configurer** un émulateur Android ou connecter un appareil

### 5. Accepter les licences Android

```bash
flutter doctor --android-licenses
```

## 📱 Configuration pour le développement

### Mode développeur sur téléphone Android

1. **Aller dans** Paramètres > À propos du téléphone
2. **Appuyer 7 fois** sur "Numéro de build"
3. **Activer** le débogage USB dans Options développeur
4. **Connecter** le téléphone via USB
5. **Autoriser** le débogage USB sur le téléphone

### Vérifier la connexion

```bash
flutter devices
```

## 🎯 Lancer ABWAR

### 1. Installer les dépendances

```bash
cd abwar_flutter
flutter pub get
```

### 2. Lancer l'application

```bash
flutter run
```

### 3. Hot Reload (développement)

- **Appuyer sur `r`** pour hot reload
- **Appuyer sur `R`** pour hot restart
- **Appuyer sur `q`** pour quitter

## 🔧 Résolution des problèmes

### Flutter non reconnu
- Vérifier que Flutter est dans le PATH
- Redémarrer le terminal
- Redémarrer l'ordinateur si nécessaire

### Appareil non détecté
- Vérifier le débogage USB
- Réinstaller les pilotes USB
- Essayer un autre câble USB

### Erreurs de compilation
- Vérifier la version de Flutter : `flutter --version`
- Mettre à jour Flutter : `flutter upgrade`
- Nettoyer le projet : `flutter clean`

## 📚 Ressources utiles

- [Documentation Flutter](https://flutter.dev/docs)
- [Cookbook Flutter](https://flutter.dev/docs/cookbook)
- [Flutter Gallery](https://gallery.flutter.dev)
- [Communauté Flutter](https://flutter.dev/community)

## 🎉 Prêt à coder !

Une fois Flutter installé, tu pourras :
- Développer et tester ABWAR en temps réel
- Utiliser le hot reload pour un développement rapide
- Déployer sur ton téléphone Android
- Créer des builds de production

---

**Bonne chance avec ABWAR ! 🚀**
