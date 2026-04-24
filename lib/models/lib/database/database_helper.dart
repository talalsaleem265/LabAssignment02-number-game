import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/game_result.dart';

/// Database helper class for managing SQLite operations
/// Uses singleton pattern to ensure only one database instance exists
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  /// Private constructor for singleton pattern
  DatabaseHelper._internal();

  /// Get singleton instance of DatabaseHelper
  factory DatabaseHelper() {
    return _instance;
  }

  /// Get or create database instance
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize the database
  Future<Database> _initDatabase() async {
    // Get the path to the documents directory
    String path = join(await getDatabasesPath(), 'number_game.db');

    // Open or create the database
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Create the database table on first run
  Future<void> _onCreate(Database db, int version) async {
    // Create game_results table
    await db.execute('''
      CREATE TABLE game_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        attempts INTEGER NOT NULL,
        result TEXT NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  /// Insert a new game result into the database
  /// Returns the id of the inserted record
  Future<int> insertGameResult(GameResult gameResult) async {
    final db = await database;
    return db.insert(
      'game_results',
      gameResult.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieve all game results from the database
  /// Results are sorted by timestamp in descending order (latest first)
  Future<List<GameResult>> getAllGameResults() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'game_results',
      orderBy: 'timestamp DESC',
    );

    return List.generate(maps.length, (i) {
      return GameResult.fromMap(maps[i]);
    });
  }

  /// Delete a specific game result by id
  /// Returns the number of records deleted
  Future<int> deleteGameResult(int id) async {
    final db = await database;
    return db.delete(
      'game_results',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete all game results from the database
  /// Returns the number of records deleted
  Future<int> deleteAllGameResults() async {
    final db = await database;
    return db.delete('game_results');
  }

  /// Get the count of all game results
  Future<int> getGameResultCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM game_results');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
