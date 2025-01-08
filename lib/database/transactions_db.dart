import 'package:sqflite/sqflite.dart';
import 'db_service.dart';
import '../models/transaction.dart';
import '../models/transaction_constants.dart';

class TxnDatabase {

  Future<void> createTable(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS $tableName (
        "$columnId" $columnIdConstraints,
        "$columnType" $columnTypeConstraints,
        "$columnAmount" $columnAmountConstraints,
        "$columnCategory" $columnCategoryConstraints,
        "$columnDate" $columnDateConstraints,
        "$columnDescription" $columnDescriptionConstraints,
        PRIMARY KEY("$columnId" AUTOINCREMENT)
      );
      """
    );
  }

  // Create
  Future<int> saveNewTxn(Txn txn) async {
    final database = await DatabaseService().database;
    return await database.insert(
      tableName, 
      txn.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  static Future<List<Txn>?> getAllTxns() async {
    final database = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Txn.fromJSON(maps[index]));
  }

  // Update
  Future<int> updateTxn(Txn txn) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName, 
      txn.toJSON(),
      where: '$columnId = ?',
      whereArgs: [txn.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Delete
  Future<int> deleteTxn(Txn txn) async {
    final database = await DatabaseService().database;
    return await database.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [txn.id],
    );
  }
}