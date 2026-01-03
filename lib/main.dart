import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';

void main() {
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
      theme: AppTheme.lightTheme,
      home: const WelcomeScreen(),
    );
  }
}