import 'package:api_parba/pages/AccueilPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ParBa',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF00C36F, {
          50: Color(0xFFE0F5E6),
          100: Color(0xFFB3E0CC),
          200: Color(0xFF80CCB3),
          300: Color(0xFF4DB399),
          400: Color(0xFF26A086),
          500: Color(0xFF00C36F),  // Couleur principale
          600: Color(0xFF00B261),
          700: Color(0xFF009F53),
          800: Color(0xFF008C46),
          900: Color(0xFF006C2D),
        }),
      ),
      // home: const LoginForm(),
      // home: const ConnexionManager(),
      home: const AccueilPage(),
    );
  }
}

