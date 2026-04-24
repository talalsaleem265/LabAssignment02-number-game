import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

/// Main entry point of the Number Guessing Game application
void main() {
  runApp(const NumberGuessingApp());
}

/// Root widget of the application
class NumberGuessingApp extends StatelessWidget {
  const NumberGuessingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Application title
      title: 'Number Guessing Game',

      /// Theme configuration
      theme: ThemeData(
        /// Primary color for the app
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,

        /// AppBar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          centerTitle: true,
        ),

        /// Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      /// Dark theme configuration
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),

      /// Use light theme by default
      themeMode: ThemeMode.light,

      /// Home screen of the app
      home: const HomeScreen(),

      /// Disable debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
