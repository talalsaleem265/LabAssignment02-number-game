import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'history_screen.dart';

/// Home Screen of the Number Guessing Game
/// Allows users to input their guess and provides feedback
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Controller for the input text field
  final TextEditingController _inputController = TextEditingController();

  /// Random number to be guessed (1-100)
  late int _secretNumber;

  /// Counter for number of attempts
  int _attempts = 0;

  /// Error message to display
  String _errorMessage = '';

  /// Flag to check if game is in progress
  bool _gameStarted = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  /// Initialize the game with a new random number
  void _initializeGame() {
    _secretNumber = DateTime.now().microsecond % 100 + 1;
    _attempts = 0;
    _gameStarted = true;
    _errorMessage = '';
    _inputController.clear();
  }

  /// Validate and process user input
  void _handleGuess() {
    // Clear previous error message
    _errorMessage = '';

    // Check if input is empty
    if (_inputController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a number';
      });
      return;
    }

    // Try to parse input as integer
    int? guess;
    try {
      guess = int.parse(_inputController.text);
    } catch (e) {
      setState(() {
        _errorMessage = 'Please enter a valid number';
      });
      return;
    }

    // Validate guess is in valid range
    if (guess < 1 || guess > 100) {
      setState(() {
        _errorMessage = 'Number must be between 1 and 100';
      });
      return;
    }

    // Increment attempts
    _attempts++;

    // Check if guess is correct and navigate to result screen
    if (guess == _secretNumber) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            secretNumber: _secretNumber,
            attempts: _attempts,
            isCorrect: true,
            onPlayAgain: _initializeGame,
          ),
        ),
      );
    } else {
      // Show feedback for incorrect guess
      String feedback = guess > _secretNumber ? 'Too High!' : 'Too Low!';
      _inputController.clear();

      setState(() {
        _errorMessage = feedback;
      });
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Guessing Game'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          /// History button in AppBar
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade700],
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Game Title
                  Text(
                    'Guess the Number',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  /// Instructions
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white30, width: 2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Think of a number between 1 and 100',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Attempts',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: Colors.white70),
                                ),
                                Text(
                                  _attempts.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  /// Input TextField
                  TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter your guess',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                    onSubmitted: (_) => _handleGuess(),
                  ),
                  const SizedBox(height: 16),

                  /// Error/Feedback Message
                  if (_errorMessage.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _errorMessage.contains('Too High') ||
                                _errorMessage.contains('Too Low')
                            ? Colors.orange.withOpacity(0.8)
                            : Colors.red.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),

                  /// Submit Button
                  ElevatedButton(
                    onPressed: _handleGuess,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                    ),
                    child: Text(
                      'Submit Guess',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
