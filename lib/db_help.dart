import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';

class DatabaseHelper{

  void createDb() async{
    var dbPath = await(getDatabasesPath());
    Database database = await openDatabase(join(dbPath, 'ddd.db'), version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT);'
      );
    });

  }

  void create_record(User user) async{
    // Open the database
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'ddd.db'),
    );

    // Retrieve and print the database version
    int ver = await db.getVersion();

    // Close the database
    await db.close();

    Database database = await openDatabase(join(await getDatabasesPath(), 'sqlite.db'), version: ver,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT);");
        });

    await database.transaction((txn) async {
      int id = await txn.rawInsert("INSERT INTO users (name, email) VALUES ("+ user.name + ", "+ user.email +");");
    });
    await database.close();
  }

  Future<List<Map<String, dynamic>>> read_users() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'ddd.db'),
    );
    List<Map<String, dynamic>> result = await database.query('users');
    await database.close();
    return result;
  }
}
