import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; 

void main() {
  runApp(const BahayKusinaApp());
}

class BahayKusinaApp extends StatelessWidget {
  const BahayKusinaApp({super.key});

  static const Color primaryOrange = Color(0xFFFF6B00);
  static const Color secondaryOrange = Color(0xFFFF8C3B);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BahayKusina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryOrange,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
            primaryOrange.value,
            const <int, Color>{
              50: Color(0xFFFFE0B2),
              100: Color(0xFFFFCC80),
              200: Color(0xFFFFB74D),
              300: Color(0xFFFFA726),
              400: Color(0xFFFF9800),
              500: primaryOrange,
              600: Color(0xFFF57C00),
              700: Color(0xFFE65100),
              800: Color(0xFFD84315),
              900: Color(0xFFBF360C),
            },
          ),
          accentColor: secondaryOrange,
        ),
        fontFamily: 'Roboto', 
        scaffoldBackgroundColor: const Color(0xFFF0F0F0),
      ),
      home: const WelcomeScreen(),
    );
  }
}