import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

/// Main entry point of the Number Guessing Game application
void main() {
  runApp(const NumberGuessingGameApp());
}

class NumberGuessingGameApp extends StatelessWidget {
  const NumberGuessingGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Guessing Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
