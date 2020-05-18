import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DataBaseHelper {
  static const PLACES_TABLE = "user_places";

  static Future<Database> _database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath,"places.db"), onCreate: (db, version) {
      return db.execute("CREATE TABLE $PLACES_TABLE(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lon REAL, address TEXT)");
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await _database();
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await _database();
    return db.query(table);
  }

}

