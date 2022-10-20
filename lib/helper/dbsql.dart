import 'dart:async';
import 'dart:ffi';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "Lecture.db");
    Database db = await openDatabase(path, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE lecture (
  id INTEGER AUTOINCREMENT NOT NULL PRIMARY KEY
)


''');
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> respose = await mydb!.rawQuery(sql);
    return respose;
  }
  insertData(String sql) async {
    Database? mydb = await db;
   int respose = await mydb!.rawInsert(sql);
    return respose;
  }
  updateData(String sql) async {
    Database? mydb = await db;
   int respose = await mydb!.rawUpdate(sql);
    return respose;
  }
deleteData(String sql) async {
    Database? mydb = await db;
   int respose = await mydb!.rawDelete (sql);
    return respose;
  }
}
