import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class Stamp {
  static final _tableName = 'Stamp'; //テーブル名

  // モデル定義
  final String id;
  final String stampInfo; //スタンプ情報
  final DateTime getDate; //取得日
  final DateTime getTime; //取得時間
  final bool invalidFlg; //無効フラグ
  final DateTime deleteAt; //削除日
  final DateTime deleteTime; //削除時間
  final num stampNum; //スタンプの数
  Stamp(
      {this.id,
      this.stampInfo,
      this.getDate,
      this.getTime,
      this.invalidFlg,
      this.deleteAt,
      this.deleteTime,
      this.stampNum});

  //StampからMap型に変換
  //カラム名に対応する必要あり
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stampinfo': stampInfo,
      'getdate': _timeConvert(getDate, "date"),
      'gettime': _timeConvert(getTime, "time"),
      'invalidflg': _isInt(invalidFlg),
      'deleteat': _timeConvert(deleteAt, "date"),
      'deletetime': _timeConvert(deleteTime, "time"),
      'stampnum': stampNum
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
  String _timeConvert(DateTime dt, String dateType) {
    String sdt;
    if (dateType == "date") {
      sdt = DateFormat('MM/dd/yyyy').format(dt);
    } else if (dateType == "time") {
      sdt = DateFormat('HH:mm:ss').format(dt);
    }
    return sdt;
  }

  @override
  String toString() {
    return 'Stamp{id: $id, stampinfo: $stampInfo, getdate:$getDate,gettime: $getTime,invalidflg:$invalidFlg,deleteat:$deleteAt,deletetime:$deleteTime,stampnum:$stampNum}';
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
