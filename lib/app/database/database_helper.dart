import 'package:muatmuat/app/core/models/language_model.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "MuatMuatDB.db";
  static final _databaseVersion = 1;
  static final tableLanguage = "tb_language";
  static final columnName = 'name';
  static final columnPageLink = 'pageLink';
  static final columnWords = 'words';
  static final columnClass = 'class';
  static final columnLanguage = 'language';
  static final columnVersion = 'version';

  static final tableListLanguage = "tb_list_language";
  static final columnTitle = 'title';
  static final columnLocale = 'locale';
  static final columnURLSegment = 'URLSegment';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableLanguage (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT NOT NULL,
      $columnPageLink TEXT NOT NULL,
      $columnWords TEXT NOT NULL,
      $columnClass TEXT NOT NULL,
      $columnLanguage TEXT NOT NULL,
      $columnVersion INTEGER NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE $tableListLanguage (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTitle TEXT NOT NULL,
      $columnLocale TEXT NOT NULL,
      $columnURLSegment TEXT NOT NULL
    )
    ''');
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    var res =
        await db.query(tableLanguage, orderBy: columnPageLink + " DESC");
    return res;
  }

  // Future<List<Map<String, dynamic>>> getVersionOrExist(String classType) async {
  //   Database db = await instance.database;
  //   var res = await db.query(table, where: '$columnClass = ?', whereArgs: [classType], limit: 1);
  //   return res;
  // }

  // insert(LanguageData language) async {
  //   Database db = await instance.database;
  //   await db.insert(table, language.toMap());
  // }

  Future insertOrUpdateLanguage(LanguageData language) async {
    try{
    Database db = await instance.database;
    var update = await db.update(tableLanguage, language.toMap(),
        where: '$columnName = ? AND $columnClass = ? AND $columnLanguage = ?',
        whereArgs: [language.name, language.type, language.language]);
    if (update == 0) {
      await db.insert(tableLanguage, language.toMap());
    } 
    }catch (e) {
      print("Fail to insert or update language: "+e.toString());
    }
  }

  Future insertOrUpdateListLanguage(ListLanguageData listLanguage) async {
    Database db = await instance.database;
    var update = await db.update(tableListLanguage, listLanguage.toMap(),
        where: '$columnLocale = ?', whereArgs: [listLanguage.locale]);
    if (update == 0) {
      await db.insert(tableListLanguage, listLanguage.toMap());
    }
  }

  Future deleteLanguage() async {
    try{
      Database db = await instance.database;
      await db.execute("DELETE FROM $tableLanguage");
    }catch (e) {
      print("Fail to delete language: "+e.toString());
    }
  }

  Future insertLanguage(LanguageData language) async {
    try{
      Database db = await instance.database;
      await db.insert(tableLanguage, language.toMap());
    }catch (e) {
      print("Fail to insert language: "+e.toString());
    }
  }

  Future deleteListLanguage() async {
    try{
      Database db = await instance.database;
      await db.execute("DELETE FROM $tableListLanguage");
    }catch (e) {
      print("Fail to delete language: "+e.toString());
    }
  }

  Future insertListLanguage(ListLanguageData listLanguage) async {
    try{
      Database db = await instance.database;
      await db.insert(tableListLanguage, listLanguage.toMap());
    }catch (e) {
      print("Fail to insert language: "+e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getLanguageVersion() async {
    Database db = await instance.database;
    // var update = await db.query(tableLanguage, distinct: true,
    //   where: "$columnLanguage = ?", whereArgs: [GlobalVariable.languageCode], orderBy: columnClass);
    var update = await db.rawQuery(
        """SELECT DISTINCT $columnClass, $columnVersion, $columnLanguage
      FROM $tableLanguage WHERE $columnLanguage = '${GlobalVariable.languageCode}'""");
    return update;
  }

  // deleteClass(String classType) async {
  //   Database db = await instance.database;
  //   await db.delete(table, where: '$columnClass = ?', whereArgs: [classType]);
  // }

  // delete(int id) async {
  //   Database db = await instance.database;
  //   await db.delete(table, where: 'id = ?', whereArgs: [id]);
  // }
  Future clearTable() async {
    Database db = await instance.database;
    await db.rawQuery("DELETE FROM $tableLanguage");
  }
}
