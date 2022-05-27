import 'package:speedtest/app/data/data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'records';

  static Future<void> initDatabase() async {
    if (_db != null) {
      return;
    }
    try {
      //create database
      String _path = await getDatabasesPath() + "/internetdata.db";
      //await deleteDatabase(_path);
      print(_path);
      _db = await openDatabase(_path, version: _version,
          onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, isp STRINTG, mode STRING, downloadSpeed STRING,uploadSpeed STRING,createddate STRING, updateddate STRIING, isChecked INTEGER NOT NULL CHECK (isChecked IN (0, 1)))",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> checkDbExitiorNot() async {
    String path = await getDatabasesPath() + "/internetdata.db";
    return await io.File(path).exists();
  }

  static Future<int> deleteRecord(int? id) async {
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> updateRecords(int? id, int checked) async {
    final data = {'isChecked': checked};
    print(id);
    final result =
        await _db!.update(_tableName, data, where: "id = ?", whereArgs: [id]);
    print(result);
    return result;
  }

  static Future<int> insertData(Datamodel datamodel) async {
    return await _db!.insert(_tableName, datamodel.toJson());
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    return await _db!.query(_tableName);
  }
}
