// import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseBackup {
  static final DatabaseBackup _instance = DatabaseBackup._internal();
  static Database? _database;

  factory DatabaseBackup() => _instance;

  DatabaseBackup._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, 'penny_pilot.db');

      return await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  void _onCreate(Database db, int version) async {
    // Create the transactions table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        amount REAL,
        date TEXT,
        email TEXT NOT NULL
      )
    ''');

    // Create the backupHistory table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS backupHistory (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  // Handle schema upgrade if needed
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // For example, we can create the backupHistory table if upgrading from version 1
      await db.execute('''
        CREATE TABLE IF NOT EXISTS backupHistory (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL,
          time TEXT NOT NULL,
          email TEXT NOT NULL
        )
      ''');
    }
  }

  // Add Backup Entry
  Future<int> addBackup(String date, String time, String email) async {
    final db = await database;
    return await db.insert(
      'backupHistory',
      {'date': date, 'time': time, 'email': email},
    );
  }

  // Get Backup Entries by Email
  Future<List<Map<String, dynamic>>> getBackupByEmail(String email) async {
    final db = await database;
    return await db.query(
      'backupHistory',
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  // Delete All Backup Entries
  Future<int> clearBackup() async {
    final db = await database;
    return await db.delete('backupHistory');
  }

  // Get Database File Path
  Future<String> getDatabasePath() async {
    final databasesPath = await getDatabasesPath();
    return join(databasesPath, 'penny_pilot.db');
  }
}
