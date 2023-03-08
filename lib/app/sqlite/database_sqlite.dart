import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseSQLite {
  static final _dbName = 'MuatMuatDB.db';
  static final _dbVersion = 1;

  final _tb_language = 'tb_language';
  final _column_id_tb_language = 'id';
  static final columnName = 'name';
  static final columnAddress = 'address';

  DatabaseSQLite._privateConstructor();
  static final DatabaseSQLite instance = DatabaseSQLite._privateConstructor();

  static Database _database;
  // Future<Database> get database async {
  //   if (_database != null) return _database;

  //   _database = await _initiateDatabase();
  //   return _database;
  // }

  // _initiateDatabase() async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String path = join(directory.path, _dbName);
  //   //await deleteDatabase(path);
  //   return await openDatabase(path, version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  // }

  // Future _onCreate(Database db, int version) {
  //   db.execute('''
  //     CREATE TABLE $_tableName (
  //       $columnId INTEGER PRIMARY KEY,
  //       $columnName TEXT NOT NULL,
  //       $columnAddress TEXT NOT NULL DEFAULT '')
  //     ''');
  // }

  // Future _onUpgrade(Database db, int oldVersion, int newVersion){
  //   db.execute('''
  //     ALTER TABLE $_tableName ADD COLUMN $columnAddress TEXT NOT NULL DEFAULT '';
  //   ''');
  // }

  // Future<int> insert(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   return await db.insert(_tableName, row);
  // }

  // Future<List<Map<String, dynamic>>> queryAll() async {
  //   Database db = await instance.database;
  //   return await db.query(_tableName);
  // }

  // Future<int> update(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   int id = row[columnId];
  //   return await db
  //       .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
  // }

  // Future<int> delete(int id) async {
  //   Database db = await instance.database;
  //   return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  // }
}