import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLDB {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> intialDb() async {
    String dataBais = await getDatabasesPath();
    String path = join(dataBais, 'Silaaty.db');
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 2,
      onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  Future<void> _onUpgrade(Database db, int oldversion, int newVersion) async {
    print("_onUpgrade: from v$oldversion to v$newVersion ===============");

    // ─── v1 → v2 : إضافة جدول البائعين ───
    if (oldversion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS sellers(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          name TEXT NOT NULL,
          phone TEXT,
          email TEXT,
          password TEXT,
          created_at TEXT,
          updated_at TEXT
        )
      ''');
      print('sellers table created in upgrade to v2');
      await db.execute('ALTER TABLE sales ADD COLUMN seller_id INTEGER');
      await db.execute('ALTER TABLE invoies ADD COLUMN seller_id INTEGER');
      print('seller_id column added to sales in upgrade to v2');
    }

    // ─── v2 → v3 : إضافة عمود seller_id لجدول sales ───
    // if (oldversion < 3) {
    // }

    // ─── v3 → v4 : ضف هنا التغييرات القادمة ───
    // if (oldversion < 4) { ... }
  }

  Future<void> _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    /// جدول التصنيفات
    batch.execute('''
    CREATE TABLE SavedVerses(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      verse_id INTEGER NOT NULL,
      chapter_title TEXT,
      sadr TEXT NOT NULL,
      ajez TEXT NOT NULL,
      note TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''');



    await batch.commit();
    print(
        'Database and tables (with sync) created successfully - v2 ======================');
  }

  // CRUD METHODS =============================================

  Future<List<Map<String, Object?>>> readData(String sql,
      [List<Object?>? arguments]) async {
    Database? mydb = await db;
    return await mydb!.rawQuery(sql, arguments);
  }

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawInsert(sql);
  }

  Future<int> updateData(String sql, List list) async {
    Database? mydb = await db;
    return await mydb!.rawUpdate(sql);
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawDelete(sql);
  }

  Future<void> mydeleteDatebase() async {
    String dataBais = await getDatabasesPath();
    String path = join(dataBais, 'Silaaty.db');
    await deleteDatabase(path);
  }

  Future<List<Map>> read(String table) async {
    Database? mydb = await db;
    return await mydb!.query(table);
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    return await mydb!.insert(table, values);
  }

  Future<int> update(
    String table,
    Map<String, Object?> values,
    String? where, [
    List<Object?>? whereArgs,
  ]) async {
    Database? mydb = await db;
    return await mydb!
        .update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
    String table,
    String? where, [
    List<Object?>? whereArgs,
  ]) async {
    Database? mydb = await db;
    return await mydb!.delete(table, where: where, whereArgs: whereArgs);
  }
}
