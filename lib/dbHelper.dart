import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stamp_app/Constants/setting.dart';

class DBHelper {
  static final _stampTable = Setting.DB_TABLES["STAMP"];
  static final _stampLogsTable = Setting.DB_TABLES["LOGS"];

  static Future<Database> databese() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, Setting.DB_PATH),
        onCreate: (db, version) async {
      await db.execute("CREATE TABLE $_stampTable ("
          "id TEXT PRIMARY KEY,"
          "data TEXT,"
          "stamp_date TEXT,"
          "stamp_time TEXT,"
          "stamp_num TEXT,"
          "useflg INTEGER,"
          "created_at TEXT,"
          "deleted_at TEXT"
          ")");
      await db.execute("CREATE TABLE $_stampLogsTable ("
          "id TEXT PRIMARY KEY,"
          "stamp_id TEXT,"
          "stamp_date TEXT,"
          "stamp_time TEXT,"
          "useflg INTEGER,"
          "created_at TEXT"
          ")");
    }, version: 1);
  }
}
