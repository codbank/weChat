import 'dart:async';

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import 'package:wechat/database/model/user.model.dart';
// 注册时模拟表
class DataBaseLoginProvider {
  DataBaseLoginProvider._();
  static final table = 'LoginClient';
  static final DataBaseLoginProvider db = DataBaseLoginProvider._();
  Database _database;
  Future<Database> get dataBase async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    /// On Android, this returns the AppData directory.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $table ("
              "id INTEGER PRIMARY KEY,"
              "account TEXT,"
              "password TEXT"
              ")",
        );
      },
    );
  }

  Future insetDB(UserPerson person) async {
    Database db = await dataBase;
    var user = await db.insert(table, person.toMap());
    return user;
  }

  selectDB() async {
    var db = await dataBase;
    var result = await db.rawQuery('SELECT * FROM $table');
    return result;
  }

  Future<bool> isLoggedIn() async {
    var db = await dataBase;
    var res = await db.query(table);
    return res.length > 0 ? true : false;
  }

  Future queryUser() async {
    var db = await dataBase;
    var result = await db.rawQuery('SELECT * FROM $table limit 1');
    List<UserPerson> list = result.isNotEmpty
        ? result.map((user) => UserPerson.formMap(user)).toList()
        : [];
    return list;
  }

  Future updataUser(UserPerson user) async {
    var db = await dataBase;
    var result = await db
        .update(table, user.toMap(), where: "id = ?", whereArgs: [user.id]);

    return result;
  }

  Future deleteClients() async {
    var db = await dataBase;
    db.rawDelete("Delete from $table");
  }

  Future<List<UserPerson>> getClinets() async {
    var db = await dataBase;
    var result = await db.query(table);
    List<UserPerson> list = result.isNotEmpty
        ? result.map((user) => UserPerson.formMap(user)).toList()
        : [];
    return list;
  }
}
