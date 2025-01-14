import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'transactions_db.dart';

class DatabaseService {
  Database? _database;
  
  Future<Database> get database async {
    if (null != _database) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'transactions.db';
    final path = await getDatabasesPath();
    return join(path,name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      singleInstance: true,
    );
    return database;
  }

  Future<void> _createDB(Database db, int version) async =>
    await TxnDatabase().createTable(db);

}