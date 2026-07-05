import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // 👈 Import du fichier généré
import 'package:awid_app/screens/auth/auth_screen.dart'; // 👈 Écran de connexion

void main() async {
  // 🔹 Assure que Flutter est initialisé avant Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Initialise Firebase avec les options générées
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔹 Lance l'application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AWID-APP',
      debugShowCheckedModeBanner: false, // 👈 Désactive le bandeau debug
      theme: ThemeData(
        primarySwatch: Colors.blue, // 👈 Couleur principale
        scaffoldBackgroundColor: Colors.white, // 👈 Fond blanc
      ),
      home: const AuthScreen(), // 👈 Écran de connexion par défaut
    );
  }
}
