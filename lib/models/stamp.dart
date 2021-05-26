import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class Stamp {
  static final _tableName = 'Stamp'; //テーブル名

  // モデル定義
  final String id;
  final String stampinfo; //スタンプ情報
  final DateTime getdate; //取得日
  final DateTime gettime; //取得時間
  final bool invalidflg; //無効フラグ
  final DateTime deleteat; //削除日
  final DateTime deletetime; //削除時間
  final num stampnum; //スタンプの数
  Stamp(
      {this.id,
      this.stampinfo,
      this.getdate,
      this.gettime,
      this.invalidflg,
      this.deleteat,
      this.deletetime,
      this.stampnum});

  //StampからMap型に変換
  //カラム名に対応する必要あり
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stampinfo': stampinfo,
      'getdate': _timeConvert(getdate, "date"),
      'gettime': _timeConvert(gettime, "time"),
      'invalidflg': _isInt(invalidflg),
      'deleteat': _timeConvert(deleteat, "date"),
      'deletetime': _timeConvert(deletetime, "time"),
      'stampnum': stampnum
    };
  }

//IntをBooleanに変換
  bool _isBoolean(int num) {
    return num == 0 ? true : false;
  }

//BooleanをIntに変換
  int _isInt(bool b) {
    return b == true ? 0 : 1;
  }

//DateTimeをStringに変換
  String _timeConvert(DateTime dt, String datetype) {
    String sdt;
    if (datetype == "date") {
      sdt = DateFormat('MM/dd/yyyy').format(dt);
    } else if (datetype == "time") {
      sdt = DateFormat('HH:mm:ss').format(dt);
    }
    return sdt;
  }

  @override
  String toString() {
    return 'Stamp{id: $id, stampinfo: $stampinfo, getdate:$getdate,gettime: $gettime,invalidflg:$invalidflg,deleteat:$deleteat,deletetime:$deletetime,stampnum:$stampnum}';
  }

  // テーブル作成
  // join関数でデータベースのパスを設定
  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(), 'stamp_database.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE $_tableName ("
            "id TEXT PRIMARY KEY,"
            "stampinfo TEXT,"
            "getdate TEXT,"
            "gettime TEXT,"
            "invalidflg INTEGER,"
            "deleteat TEXT,"
            "deletetime TEXT,"
            "stampnum INTEGER)");
      },
      version: 1,
    );
    return _database;
  }
}
