import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/database_helper.dart';
import '../models/game_result.dart';
import 'history_screen.dart';

/// Result Screen to display the outcome of a guessing game
class ResultScreen extends StatefulWidget {
  /// The secret number that was being guessed
  final int secretNumber;

  /// Number of attempts taken to guess correctly
  final int attempts;

  /// Whether the guess was correct
  final bool isCorrect;

  /// Callback function when user wants to play again
  final Function onPlayAgain;

  const ResultScreen({
    Key? key,
    required this.secretNumber,
    required this.attempts,
    required this.isCorrect,
    required this.onPlayAgain,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  /// Database helper instance
  late DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper();
    // Save the game result to database if it's a win
    if (widget.isCorrect) {
      _saveGameResult();
    }
  }

  /// Save the winning game result to the database
  Future<void> _saveGameResult() async {
    // Create a game result object
    final gameResult = GameResult(
      attempts: widget.attempts,
      result: 'win',
      timestamp: DateTime.now().toIso8601String(),
    );

    // Insert into database
    await _dbHelper.insertGameResult(gameResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Result'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade700],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Result Icon
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Icon(
                    widget.isCorrect ? Icons.check_circle : Icons.close,
                    size: 80,
                    color: widget.isCorrect ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 24),

                /// Result Message
                Text(
                  widget.isCorrect ? 'Congratulations!' : 'Game Over!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                /// Result Details
                if (widget.isCorrect)
                  Text(
                    'You guessed the correct number!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                const SizedBox(height: 32),

                /// Secret Number Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white30, width: 2),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'The Secret Number',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.secretNumber.toString(),
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                /// Attempts Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white30, width: 2),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Total Attempts',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.attempts.toString(),
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                /// Play Again Button
                ElevatedButton(
                  onPressed: () {
                    widget.onPlayAgain();
                    Navigator.of(context).pop();
                  },
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
                    'Play Again',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                  ),
                ),
                const SizedBox(height: 16),

                /// View History Button
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    side: const BorderSide(color: Colors.amber, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'View History',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
