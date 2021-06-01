import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/toInt.dart';

class Stamp {
  static final _tableName = 'Stamp'; // テーブル名

  // モデル定義
  final String id;
  final String stampInfo; // スタンプ情報
  final DateTime getDate; // 取得日
  final DateTime getTime; // 取得時間
  final String stampNum; // スタンプの数
  final bool deletedFlg; // 使用済みフラグ
  final DateTime createdAt; // スタンプが押された時間
  final DateTime deletedAt; // 削除日時
  Stamp(
      {this.id,
      this.stampInfo,
      this.getDate,
      this.getTime,
      this.stampNum,
      this.deletedFlg,
      this.createdAt,
      this.deletedAt});
  // StampからMap型に変換
  // カラム名に対応する必要あり
  Map<String, dynamic> toMap() {
    String toDate = toDateOrTime(getDate, "date");
    String toTime = toDateOrTime(getTime, "time");
    int deleted = toInt(deletedFlg);
    return {
      'id': id,
      'stampinfo': stampInfo,
      'getdate': toDate,
      'gettime': toTime,
      'stampnum': stampNum,
      'deletedflg': deleted,
      'createdat': createdAt.toString(),
      'deletedat': deletedAt.toString()
    };
  }

  @override
  String toString() {
    return 'Stamp{id: $id, stampinfo: $stampInfo, getdate:$getDate,gettime: $getTime,,stampnum:$stampNum,deletedflg:$deletedFlg,,createdat:$createdAt,deletedat:$deletedAt}';
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
            "stampnum TEXT,"
            "deletedflg INTEGER,"
            "createdat TEXT,"
            "deletedat TEXT"
            ")");
      },
      version: 1,
    );
    return _database;
  }
}
