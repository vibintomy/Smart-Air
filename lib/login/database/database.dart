import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'user.db');
    return await openDatabase(path, version: 2, onCreate: _createDB,
     onUpgrade: (db, oldVersion, newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE temperature (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          value REAL
        )
      ''');
    }
  },);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT,
        password TEXT
      )
    ''');
     await db.execute('''
    CREATE TABLE temperature (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      value REAL
    )
  '''); 
   await db.execute('''
    CREATE TABLE power_saving (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      enabled INTEGER
    )
  ''');

  // Insert default (0 = off)
  await db.insert('power_saving', {'enabled': 0});
  }

  Future<int> insertUser(String userId, String password) async {
    final db = await database;

    return await db.insert('users', {
      'userId': userId,
      'password': password,
    });
  }
  Future<int> saveTemperature(double value) async {
  final db = await database;

  return await db.insert(
    'temperature',
    {'value': value},
  );
}

Future<double?> getLastTemperature() async {
  final db = await database;

  final result = await db.query(
    'temperature',
    orderBy: 'id DESC',
    limit: 1,
  );

  if (result.isNotEmpty) {
    return result.first['value'] as double;
  }
  return null;
}
Future<int> setPowerSaving(bool enabled) async {
  final db = await database;
  return await db.update(
    'power_saving',
    {'enabled': enabled ? 1 : 0},
    where: 'id = 1',
  );
}

Future<bool> getPowerSaving() async {
  final db = await database;
  final result = await db.query('power_saving', where: 'id = 1');

  if (result.isNotEmpty) {
    return result.first['enabled'] == 1;
  }
  return false;
}

}
