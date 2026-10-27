import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/intro/verdant_intro_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const VerdantEstatesApp());
}

class VerdantEstatesApp extends StatelessWidget {
  const VerdantEstatesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verdant Estates',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const VerdantIntroScreen(),
    );
  }
}
