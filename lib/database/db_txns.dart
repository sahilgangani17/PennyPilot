import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:penny_pilot/models/transaction_constants.dart';
import 'package:penny_pilot/models/transaction.dart';

class DatabaseTxn {

  DatabaseTxn._privateConstructor();
  static final DatabaseTxn instance = DatabaseTxn._privateConstructor();

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
        "$columnId" $columnIdConstraints,
        "$columnEmail" $columnEmailConstraints,
        "$columnType" $columnTypeConstraints,
        "$columnAmount" $columnAmountConstraints,
        "$columnCategory" $columnCategoryConstraints,
        "$columnDate" $columnDateConstraints,
        "$columnDescription" $columnDescriptionConstraints
      );
      '''
    );
  }

  // Create Txn
  Future<int> saveNewTxn(Txn txn) async {
    Database db = await instance.database;
    return await db.insert(
      tableName, 
      txn.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read All Txns
  Future<List<Txn>> getAllTxns(String email) async {
    Database db = await instance.database;
    var txns = await db.query(
      tableName, 
      where: '$columnEmail = ?',
      whereArgs: [email],
      orderBy: '$columnId DESC'
    );
    List<Txn> txnsList = txns.isNotEmpty
      ? txns.map((c) => Txn.fromJSON(c)).toList()
      : [];
    return txnsList;
  }

  // Read Recent Transactions
  Future<List<Txn>> get5RecentTxns(String email) async {
    Database db = await instance.database;
    var txns = await db.query(
      tableName, 
      where: '$columnEmail = ?',
      whereArgs: [email],
      orderBy: '$columnId DESC',
      limit: 5
    );
    List<Txn> txnsList = txns.isNotEmpty
      ? txns.map((c) => Txn.fromJSON(c)).toList()
      : [];
    return txnsList;
  }

  // Read All Expenses
  Future<List<Txn>> getExpensesTxns(String email) async {
    Database db = await instance.database;
    var txns = await db.query(
      tableName, orderBy: '$columnId DESC',
      where: '$columnType = ? && $columnEmail = ?',
      whereArgs: ['Expenses', email]
    );
    List<Txn> txnsList = txns.isNotEmpty
      ? txns.map((c) => Txn.fromJSON(c)).toList()
      : [];
    return txnsList;
  }

  // Read All Incomes
  Future<List<Txn>> getIncomeTxns(String email) async {
    Database db = await instance.database;
    var txns = await db.query(
      tableName, orderBy: '$columnId DESC',
      where: '$columnType = ? && $columnEmail = ?',
      whereArgs: ['Income', email]
    );
    List<Txn> txnsList = txns.isNotEmpty
      ? txns.map((c) => Txn.fromJSON(c)).toList()
      : [];
    return txnsList;
  }

  // Update Txn
  Future<int> updateTxn(Txn txn) async {
    Database db = await instance.database;
    return await db.update(
      tableName, 
      txn.toJSON(),
      where: '$columnId = ?',
      whereArgs: [txn.id],
      conflictAlgorithm: ConflictAlgorithm.rollback,
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

  // Get Total Income
  Future<double> getTotalIncome(String email) async {
    Database db = await instance.database;
    var result = await db.rawQuery('''
      SELECT SUM($columnAmount) 
      FROM $tableName 
      WHERE $columnType = ? AND $columnEmail = ?
      ''',
      ['Income',email]
    );
    
    if (result.isNotEmpty) {
      return result.first.values.first as double? ?? 0.0;
    }
    return 0.0;
  }

  // Get Total Expense
  Future<double> getTotalExpense(String email) async {
    Database db = await instance.database;
    var result = await db.rawQuery('''
      SELECT SUM($columnAmount) 
      FROM $tableName 
      WHERE $columnType = ? AND $columnEmail = ?
      ''',
      ['Expenses',email]
    );
    
    if (result.isNotEmpty) {
      return result.first.values.first as double? ?? 0.0;
    }
    return 0.0;
  }


  Future<Map<String, double>> getCategoryWiseExpenses(String email) async {
    Database db = await instance.database;
    var result = await db.rawQuery('''
      SELECT $columnCategory, 
      SUM($columnAmount) 
      FROM $tableName 
      WHERE $columnType = ? AND $columnEmail = ?
      GROUP BY $columnCategory
      ''',
      ['Expenses',email]
    );

    Map<String, double> categoryData = {};
    for (var row in result) {
      // Ensure that category is a String and total amount is a double
      String category = row[columnCategory] as String? ?? ''; // Handle null categories if necessary
      double totalAmount = row['SUM($columnAmount)'] as double? ?? 0.0; // Handle null amount

      // Add the category and total expense to the map
      categoryData[category] = totalAmount;
    }
    return categoryData;
  }

  Future<Map<String, double>> getCategoryWiseIncome(String email) async {
    Database db = await instance.database;
    var result = await db.rawQuery('''
      SELECT $columnCategory, 
      SUM($columnAmount) 
      FROM $tableName 
      WHERE $columnType = ? AND $columnEmail = ?
      GROUP BY $columnCategory
      ''',
      ['Income',email]
    );

    Map<String, double> categoryData = {};

    for (var row in result) {
      // Ensure you're casting to String and double properly
      String category = row[columnCategory] as String; // Cast to String
      double totalAmount = row['SUM($columnAmount)'] as double; // Cast to double
      categoryData[category] = totalAmount;
    }
    
    return categoryData;
  }



}