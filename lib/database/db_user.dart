import 'package:penny_pilot/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Database User Class
class DatabaseUser {
  static Database? _database;

  // Singleton pattern
  static final DatabaseUser instance = DatabaseUser._init();

  DatabaseUser._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    // If database doesn't exist, open or create it
    _database = await _initDB('users_DB.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE IF NOT EXISTS users ( 
        id $idType,
        email $textType,
      )
    ''');
  }

  // Insert user data
  Future<int> insertUser(User user) async {
    final db = await instance.database;
    return await db.insert(
      'users', 
      user.toJSON(), 
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  // Fetch All Users
  Future<List<User>> fetchAllUsers() async {
    Database db = await instance.database;
    var users = await db.query('users');
    List<User> usersList = users.isNotEmpty
      ? users.map((c) => User.fromJSON(c)).toList()
      : [];
    return usersList;
  }

  /* // Fetch user data
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final db = await instance.database;
    return await db.query('users'); // Fetch all users
  }

  // Fetch a specific user by ID
  Future<Map<String, dynamic>?> fetchUserById(int id) async {
    final db = await instance.database;
    var result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null; // Return null if no user found
  }

  Future<List<Map<String, dynamic>>> fetchUsersByEmail(String email) async {
    final db = await instance.database;
    return await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
  } */
}
