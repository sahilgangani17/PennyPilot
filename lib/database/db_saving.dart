import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Database Service
class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('savings.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS saving_goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        target_amount REAL NOT NULL,
        saved_amount REAL DEFAULT 0,
        created_at TEXT NOT NULL
      );
    ''');
  }

  Future<int> addSavingGoal(String title, double targetAmount) async {
    final db = await instance.database;
    return await db.insert('saving_goals', {
      'title': title,
      'target_amount': targetAmount,
      'saved_amount': 0,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> fetchAllGoals() async {
    final db = await instance.database;
    return await db.query('saving_goals', orderBy: 'id DESC');
  }

  Future<int> updateGoalProgress(int id, double newSavedAmount) async {
    final db = await instance.database;
    return await db.update('saving_goals', {'saved_amount': newSavedAmount}, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteGoal(int id) async {
    final db = await instance.database;
    return await db.delete('saving_goals', where: 'id = ?', whereArgs: [id]);
  }
}
