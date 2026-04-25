import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/game_result.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<GameResult>> _gameResults;

  @override
  void initState() {
    super.initState();
    _gameResults = _dbHelper.getAllGameResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Results'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<GameResult>>(
        future: _gameResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No game results yet'));
          } else {
            List<GameResult> results = snapshot.data!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                GameResult result = results[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text('Number: ${result.number}'),
                    subtitle: Text(
                      'Attempts: ${result.attempts} | Date: ${result.date.substring(0, 10)}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await _dbHelper.deleteGameResult(result.id!);
                        setState(() {
                          _gameResults = _dbHelper.getAllGameResults();
                        });
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}