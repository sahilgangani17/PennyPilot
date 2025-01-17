import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// Database User Class
class DatabaseUser{
  static Database? _database;

  // Singleton pattern
  static final DatabaseUser instance = DatabaseUser._init();

  DatabaseUser._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    // If database doesn't exist, open or create it
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute(''' 
      CREATE TABLE users ( 
        id $idType, 
        username $textType,
        email $textType,
        phoneno $textType,
        password $textType
      )
    ''');
  }

  // Insert user data
  Future<void> insertUser(Map<String, dynamic> userData) async {
    final db = await instance.database;
    await db.insert('users', userData, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
