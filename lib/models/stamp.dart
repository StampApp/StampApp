import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/toInt.dart';
import 'package:stamp_app/Util/Enums/enumDateType.dart';

class Stamp {
  // static final _tableName = 'Stamp'; // テーブル名

  // モデル定義
  final String id;
  final String data; // スタンプ情報
  final DateTime getDate; // 取得日
  final DateTime getTime; // 取得時間
  final String stampNum; // スタンプの数
  final bool useFlg; // 使用済みフラグ
  final DateTime createdAt; // スタンプが押された時間
  final DateTime deletedAt; // 削除日時

  Stamp(
      {this.id,
      this.data,
      this.getDate,
      this.getTime,
      this.stampNum,
      this.useFlg,
      this.createdAt,
      this.deletedAt});

  // StampからMap型に変換
  // カラム名に対応する必要あり
  Map<String, dynamic> toMap() {
    String toDate = formatDateTimeToString(getDate, EnumDateType.date);
    String toTime = formatDateTimeToString(getTime, EnumDateType.time);
    int stampUseFlg = parseBooleanToInt(useFlg);
    return {
      'id': id,
      'data': data,
      'stamp_date': toDate,
      'stamp_time': toTime,
      'stamp_num': stampNum,
      'useflg': stampUseFlg,
      'created_at': createdAt.toString(),
      'deleted_at': deletedAt.toString()
    };
  }

  @override
  String toString() {
    return 'Stamp{id: $id, data: $data, stamp_date: $getDate, stamp_time: $getTime, stamp_num: $stampNum, useflg: $useFlg, created_at: $createdAt, deleted_at: $deletedAt}';
  }

  // テーブル作成
  // join関数でデータベースのパスを設定
  // static Future<Database> get database async {
  //   final Future<Database> _database = openDatabase(
  //     join(await getDatabasesPath(), 'stamp_database.db'),
  //     onCreate: (db, version) {
  //       return db.execute("CREATE TABLE $_tableName ("
  //           "id TEXT PRIMARY KEY,"
  //           "data TEXT,"
  //           "stamp_date TEXT,"
  //           "stamp_time TEXT,"
  //           "stamp_num TEXT,"
  //           "useflg INTEGER,"
  //           "created_at TEXT,"
  //           "deleted_at TEXT"
  //           ")");
  //     },
  //     version: 1,
  //   );
  //   return _database;
  // }
}
