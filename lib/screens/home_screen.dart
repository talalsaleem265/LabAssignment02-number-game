import 'package:flutter/material.dart';
import 'dart:math';
import '../db/database_helper.dart';
import '../models/game_result.dart';
import '../widgets/custom_button.dart';
import 'result_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int randomNumber;
  late int attempts;
  late TextEditingController _guessController;
  String feedback = '';
  bool gameOver = false;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _guessController = TextEditingController();
    _initializeGame();
  }

  void _initializeGame() {
    randomNumber = Random().nextInt(100) + 1;
    attempts = 0;
    feedback = '';
    gameOver = false;
    _guessController.clear();
  }

  void _checkGuess() {
    if (_guessController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a number')),
      );
      return;
    }

    int guess = int.parse(_guessController.text);
    attempts++;

    if (guess == randomNumber) {
      setState(() {
        feedback = 'Correct! You won!';
        gameOver = true;
      });
      _saveGameResult();
      _showGameOverDialog();
    } else if (guess > randomNumber) {
      setState(() {
        feedback = 'Too High! Try again.';
      });
    } else {
      setState(() {
        feedback = 'Too Low! Try again.';
      });
    }

    _guessController.clear();
  }

  void _saveGameResult() async {
    GameResult result = GameResult(
      number: randomNumber,
      attempts: attempts,
      date: DateTime.now().toString(),
    );
    await _dbHelper.insertGameResult(result);
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over!'),
        content: Text('You guessed the number in $attempts attempts!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _initializeGame();
              });
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResultScreen()),
              );
            },
            child: const Text('View History'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Guessing Game'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Guess a number between 1 and 100',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _guessController,
              keyboardType: TextInputType.number,
              enabled: !gameOver,
              decoration: InputDecoration(
                hintText: 'Enter your guess',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Guess',
              onPressed: gameOver ? null : _checkGuess,
            ),
            const SizedBox(height: 20),
            Text(
              feedback,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: gameOver ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Attempts: $attempts',
              style: const TextStyle(fontSize: 16),
            ),
            if (gameOver)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CustomButton(
                  label: 'New Game',
                  onPressed: () {
                    setState(() {
                      _initializeGame();
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _guessController.dispose();
    super.dispose();
  }
}