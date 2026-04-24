/// Model class to represent a game result stored in the database
class GameResult {
  /// Unique identifier for the game result
  final int? id;

  /// Number of attempts taken to guess the correct number
  final int attempts;

  /// Status of the game: 'win' or 'lose'
  final String result;

  /// Timestamp when the game was completed (ISO 8601 format)
  final String timestamp;

  /// Constructor for GameResult
  GameResult({
    this.id,
    required this.attempts,
    required this.result,
    required this.timestamp,
  });

  /// Convert GameResult object to a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'attempts': attempts,
      'result': result,
      'timestamp': timestamp,
    };
  }

  /// Create a GameResult object from a database Map
  factory GameResult.fromMap(Map<String, dynamic> map) {
    return GameResult(
      id: map['id'] as int?,
      attempts: map['attempts'] as int,
      result: map['result'] as String,
      timestamp: map['timestamp'] as String,
    );
  }

  @override
  String toString() =>
      'GameResult(id: $id, attempts: $attempts, result: $result, timestamp: $timestamp)';
}
