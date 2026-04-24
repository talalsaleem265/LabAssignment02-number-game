# Number Guessing Game

A Flutter-based Number Guessing Game application where users guess a randomly generated number between 1 and 100. The app provides real-time feedback (high, low, or correct), tracks attempts, and stores complete game history using SQLite database.

## 🎯 Features

- **Random Number Generation**: Generates a random number between 1 and 100
- **Real-time Feedback**: Provides immediate feedback (Too High, Too Low, or Correct)
- **Attempt Tracking**: Keeps track of the number of attempts made
- **Input Validation**: Validates user input for empty values and invalid entries
- **Game History**: Stores all previous game results with timestamps
- **SQLite Database**: Persistent storage using sqflite package
- **Material Design UI**: Clean and intuitive user interface
- **Navigation**: Smooth navigation between screens

## 📁 Project Structure

```
number_guessing_game/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── models/
│   │   └── game_result.dart         # GameResult data model
│   ├── database/
│   │   └── database_helper.dart     # SQLite database operations
│   └── screens/
│       ├── home_screen.dart         # Home screen with game logic
│       ├── result_screen.dart       # Result screen display
│       └── history_screen.dart      # Game history display
├── test/                            # Test files
├── pubspec.yaml                     # Dependencies
├── analysis_options.yaml            # Dart analysis rules
├── .gitignore                       # Git ignore file
└── README.md                        # This file
```

## 🔧 Dependencies

- **flutter**: Flutter SDK
- **sqflite**: SQLite database plugin
- **path**: File path operations
- **intl**: Date/time formatting

## 📦 Installation

### Prerequisites
- Flutter SDK (version 3.0.0 or higher)
- Dart SDK (included with Flutter)
- Android emulator or iOS simulator

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/talalsaleem265/LabAssignment02-number-game.git
   cd number_guessing_game
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # On Android emulator
   flutter run

   # On specific device
   flutter run -d <device-id>
   ```

## 🎮 How to Play

1. **Start the Game**: The app generates a random number between 1-100
2. **Make a Guess**: Enter your guess in the input field
3. **Get Feedback**: 
   - "Too Low" - Your guess is lower than the secret number
   - "Too High" - Your guess is higher than the secret number
   - "Correct" - You've guessed the right number!
4. **Track Attempts**: View the number of attempts made
5. **View History**: Check your previous game results and statistics

## 🗄️ Database Schema

### game_results Table

| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER | Primary key (Auto-increment) |
| attempts | INTEGER | Number of attempts taken |
| result | TEXT | Game result ('win' or 'lose') |
| timestamp | TEXT | ISO 8601 formatted timestamp |

## 📱 Screens

### Home Screen
- Input field for user guesses
- Real-time feedback on guesses
- Attempt counter
- Navigation to history
- Material Design UI with gradient background

### Result Screen
- Displays game outcome (Correct/Too High/Too Low)
- Shows secret number
- Shows total attempts
- Play Again button
- View History button
- Auto-saves winning games to database

### History Screen
- Lists all previous games
- Shows attempt count and timestamp
- Delete individual games
- Delete all history with confirmation
- Empty state when no games

## 🚀 Running on Emulator

### Android Emulator
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <emulator-name>

# Or simply run (if only one device)
flutter run
```

### iOS Simulator (macOS only)
```bash
# Open simulator
open -a Simulator

# Run app
flutter run
```

## 🛠️ Development

### Code Organization
- **models/**: Data models and entities
- **database/**: Database operations and initialization
- **screens/**: UI screens and widgets

### Key Classes

#### GameResult (models/game_result.dart)
- Represents a completed game
- Contains: id, attempts, result, timestamp
- Methods: toMap(), fromMap()

#### DatabaseHelper (database/database_helper.dart)
- Singleton pattern implementation
- CRUD operations for game results
- Database initialization and schema creation

#### HomeScreen (screens/home_screen.dart)
- Main game logic
- User input and validation
- Attempt tracking

#### ResultScreen (screens/result_screen.dart)
- Display game outcome
- Save winning games to database
- Navigation controls

#### HistoryScreen (screens/history_screen.dart)
- Display all games from database
- Delete individual or all games
- Format timestamps

## 📝 Code Comments

All code files include comprehensive comments explaining:
- Class purposes and responsibilities
- Method descriptions and parameters
- Important logic and algorithms
- Database operations

## 🐛 Troubleshooting

### App won't run
- Ensure Flutter is properly installed: `flutter doctor`
- Run `flutter clean` and `flutter pub get`
- Check emulator/device is running: `flutter devices`

### Database errors
- Delete app data and reinstall: `flutter clean`
- Check write permissions for database file

### UI issues
- Restart the emulator
- Update Flutter: `flutter upgrade`

## 🎨 Customization

### Change number range
Edit `lib/screens/home_screen.dart`:
```dart
_secretNumber = DateTime.now().microsecond % 100 + 1; // Change 100 to desired range
```

### Change theme colors
Edit `lib/main.dart` to modify the theme colors:
```dart
primarySwatch: Colors.deepPurple, // Change color
```

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

- **Talal Saleem** (talalsaleem265)
- GitHub: https://github.com/talalsaleem265

## 📞 Support

For issues, questions, or suggestions, please open an issue on GitHub or contact the author.

---

**Happy Guessing! 🎲**
