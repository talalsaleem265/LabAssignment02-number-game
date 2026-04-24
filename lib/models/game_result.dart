/// Model class to represent a game result
/// Stores information about a completed game session
class GameResult {
  final int? id;
  final int attempts;
  final String result; // 'win' or 'lose'
  final DateTime timestamp;

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
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Create a GameResult object from database map
  factory GameResult.fromMap(Map<String, dynamic> map) {
    return GameResult(
      id: map['id'] as int?,
      attempts: map['attempts'] as int,
      result: map['result'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }

  @override
  String toString() {
    return 'GameResult(id: \$id, attempts: \$attempts, result: \$result, timestamp: \$timestamp)';
  }
}