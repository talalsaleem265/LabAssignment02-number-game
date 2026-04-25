import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/game_result.dart';

class DatabaseHelper {
  static const _databaseName = 'number_game.db';
  static const _databaseVersion = 1;
  static const table = 'game_results';

  static const columnId = 'id';
  static const columnNumber = 'number';
  static const columnAttempts = 'attempts';
  static const columnDate = 'date';

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnNumber INTEGER NOT NULL,
        $columnAttempts INTEGER NOT NULL,
        $columnDate TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertGameResult(GameResult result) async {
    Database db = await database;
    return await db.insert(table, result.toMap());
  }

  Future<List<GameResult>> getAllGameResults() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return GameResult.fromMap(maps[i]);
    });
  }

  Future<int> deleteGameResult(int id) async {
    Database db = await database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllGameResults() async {
    Database db = await database;
    await db.delete(table);
  }
}