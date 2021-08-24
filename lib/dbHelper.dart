import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stamp_app/Constants/setting.dart';

/// データベースを定義し、DB呼び出しを行うクラス
/// 
/// 呼び出された時テーブルがなどが存在しない場合、作成し接続を行う
/// 作成済みの場合は、既存のDBに接続する
/// 
/// 新たなテーブルを追加したい場合、[db.execute]を追加し定義する
/// 
/// 参考文献: https://flutter.ctrnost.com/logic/sqlite/#データベースに接続する

class DBHelper {
  static final _stampTable = Setting.DB_TABLES["STAMP"];
  static final _stampLogsTable = Setting.DB_TABLES["LOGS"];

  static Future<Database> databese() async {
    final dbPath = await getDatabasesPath();
    // パスとデータベース名を指定し接続する
    return openDatabase(join(dbPath, Setting.DB_PATH),
        onCreate: (db, version) async {
      // $_stampTableの定義
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
      // $_stampLogsTableの定義
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
