import 'package:flutter/material.dart';
import 'screens/accueil_screen.dart';

void main() {
  runApp(const AbwarApp());
}

class AbwarApp extends StatelessWidget {
  const AbwarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABWAR',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B35),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B35),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const AccueilScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
