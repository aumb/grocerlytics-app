import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  const LocalDatabase({
    required this.database,
  });

  final Database database;

  static Future<Database> get initDatabase async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'grocerlytics_local.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  static Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE receipts (
        id TEXT PRIMARY KEY,
        user_id TEXT,
        currency_id INTEGER,
        store_name TEXT,
        total_amount REAL NOT NULL,
        purchase_date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE receipt_items (
        id TEXT PRIMARY KEY,
        receipt_id INTEGER NOT NULL,
        item_name TEXT NOT NULL,
        price REAL NOT NULL,
        quantity REAL NOT NULL,
        quantity_unit_id INTEGER,
        category_id INTEGER,
        created_at TEXT NOT NULL,
        item_abrv TEXT,
        FOREIGN KEY (receipt_id) REFERENCES receipts(id) ON DELETE CASCADE
      )
    ''');
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY,
        label TEXT NOT NULL UNIQUE,
        color TEXT NOT NULL UNIQUE
      )
    ''');
    await db.execute('''
      CREATE TABLE currencies (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL UNIQUE,
        symbol TEXT NOT NULL UNIQUE,
        code TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE quantity_units (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL UNIQUE,
        shorthand TEXT NOT NULL UNIQUE
      )
    ''');
  }

  Future<void> insert(String tableName, Map<String, Object?> values) =>
      database.insert(tableName, values);

  Future<List<Map<String, dynamic>>> select(
    String tableName, {
    String? where,
  }) =>
      database.query(
        tableName,
        where: where,
      );

  Future<void> delete(
    String tableName, {
    String? where,
  }) =>
      database.delete(tableName, where: where);

  Future<void> transaction<T>(Future<T> Function(Transaction) action,
          {bool? exclusive}) =>
      database.transaction(action, exclusive: exclusive);

  Future<List<Map<String, Object?>>> rawQuery(String sql,
          [List<Object?>? arguments]) =>
      database.rawQuery(sql, arguments);

  Batch batch() => database.batch();
}
