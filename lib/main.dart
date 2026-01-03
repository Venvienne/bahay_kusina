import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart'; 

void main() {
  // Ensure Flutter is initialized if you add plugins later
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const BahayKusinaApp());
}

class BahayKusinaApp extends StatelessWidget {
  const BahayKusinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BahayKusina',
      debugShowCheckedModeBanner: false,
      
      // We pull the entire theme configuration from our AppTheme class
      theme: AppTheme.lightTheme,
      
      // Your starting screen
      home: const WelcomeScreen(),
    );
  }
}