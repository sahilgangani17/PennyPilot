const String dbName = 'transactions.db';

const int kVersion1 = 1;

String tableName = 'AllTxns';

String columnId = 'id';
String columnEmail = 'email';
String columnType = 'type';
String columnAmount = 'amount';
String columnCategory = 'category';
String columnDate = 'date';
String columnDescription = 'description';

String columnIdConstraints = 'INTEGER PRIMARY KEY AUTOINCREMENT';
String columnEmailConstraints = 'TEXT NOT NULL';
String columnTypeConstraints = 'VARCHAR(20) NOT NULL';
String columnAmountConstraints = 'DOUBLE NOT NULL';
String columnCategoryConstraints = 'VARCHAR(50) NOT NULL';
String columnDateConstraints = 'CURRENT_DATE';
String columnDescriptionConstraints = 'TEXT';
