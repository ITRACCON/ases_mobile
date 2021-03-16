import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final initScript = [
  '''
  CREATE TABLE user (
  username TEXT,
  email TEXT,
  image TEXT
  );
  ''',
];

List migrationScript = [
  ...initScript,
];

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ases.db');

    var database = await openDatabase(path,
        version: migrationScript.length + 1,
        onCreate: initDB,
        onUpgrade: onUpgrade,
        onConfigure: onConfigure);
    return database;
  }

  static Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) async {
    for (var i = oldVersion - 1; i < newVersion - 1; i++) {
      await database.execute(migrationScript[i]);
    }
  }

  // при первом запуске необходимо выполнять скрипты миграций в initDB, т.к. onUpgrade не сработает из-за того, что версии одинаковые
  void initDB(Database database, int version) async {
    migrationScript.forEach((script) async => await database.execute(script));
  }
}
