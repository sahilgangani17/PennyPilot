import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:penny_pilot/models/transaction_constants.dart';
import 'package:penny_pilot/models/transaction.dart';

class DatabaseService {

  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _database;
  
  Future<Database> get database async =>
    _database ??= await _initialize();

  Future<String> get fullPath async {
    const name = dbName;
    final path = await getDatabasesPath();
    return join(path,name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: kVersion1,
      onCreate: _createDB,
    );
    return database;
  }

  Future<void> _createDB(Database db, int version) async =>
    await createTable(db);

  Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        "$columnId" INTEGER PRIMARY KEY AUTOINCREMENT,
        "$columnType" $columnTypeConstraints,
        "$columnAmount" $columnAmountConstraints,
        "$columnCategory" $columnCategoryConstraints,
        "$columnDate" $columnDateConstraints,
        "$columnDescription" $columnDescriptionConstraints
      );
      '''
    );
  }

  // Create
  Future<int> saveNewTxn(Txn txn) async {
    Database db = await instance.database;
    return await db.insert(
      tableName, 
      txn.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  Future<List<Txn>> getAllTxns() async {
    Database db = await instance.database;
    var txns = await db.query(tableName, orderBy: '$columnId DESC');
    List<Txn> txnsList = txns.isNotEmpty
      ? txns.map((c) => Txn.fromJSON(c)).toList()
      : [];
    return txnsList;
  }

  // Recent Transactions Read
  Future<List<Txn>> get5RecentTxns() async {
    Database db = await instance.database;
    var txns = await db.query(tableName, orderBy: '$columnId DESC', limit: 5);
    List<Txn> txnsList = txns.isNotEmpty
      ? txns.map((c) => Txn.fromJSON(c)).toList()
      : [];
    return txnsList;
  }

  // Expenses Read
  Future<List<Txn>> getExpensesTxns() async {
    Database db = await instance.database;
    var txns = await db.query(
      tableName, orderBy: '$columnId DESC',
      where: '$columnType = ?',
      whereArgs: ['Expenses']
    );
    List<Txn> txnsList = txns.isNotEmpty
      ? txns.map((c) => Txn.fromJSON(c)).toList()
      : [];
    return txnsList;
  }

  // Incomes Read
  Future<List<Txn>> getIncomeTxns() async {
    Database db = await instance.database;
    var txns = await db.query(
      tableName, orderBy: '$columnId DESC',
      where: '$columnType = ?',
      whereArgs: ['Income']
    );
    List<Txn> txnsList = txns.isNotEmpty
      ? txns.map((c) => Txn.fromJSON(c)).toList()
      : [];
    return txnsList;
  }

  // Update
  Future<int> updateTxn(Txn txn) async {
    Database db = await instance.database;
    return await db.update(
      tableName, 
      txn.toJSON(),
      where: '$columnId = ?',
      whereArgs: [txn.id],
    );
  }

  // Delete
  Future<int> deleteTxn(Txn txn) async {
    Database db = await instance.database;
    return await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [txn.id],
    );
  }
}