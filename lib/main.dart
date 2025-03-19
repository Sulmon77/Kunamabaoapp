import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kunamabao_app/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FPL Performance Checker',
      theme: ThemeData(
        primaryColor: const Color(0xFF37003C), // Premier League purple
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF37003C),
          secondary: const Color(0xFF00FF87), // Premier League green
        ),
        fontFamily: 'SFProDisplay', // System font alternative
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF37003C),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00FF87), width: 2),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}