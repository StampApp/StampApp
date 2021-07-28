import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/toInt.dart';
import 'package:stamp_app/Util/Enums/enumDateType.dart';

class StampLogs {
  // static final _tableName = 'StampLogs'; // テーブル名

  // モデル定義
  final String id;
  final String stampId; // スタンプID
  final DateTime getDate; // 取得日
  final DateTime getTime; // 取得時間
  final bool useFlg; // 使用済みフラグ
  final DateTime? createdAt; // スタンプが押された時間

  StampLogs({
    required this.id,
    required this.stampId,
    required this.getDate,
    required this.getTime,
    required this.useFlg,
    this.createdAt
  });

  Map<String, dynamic> toMap() {
    String toDate = formatDateTimeToString(getDate, EnumDateType.date);
    String toTime = formatDateTimeToString(getTime, EnumDateType.time);
    int stampUseFlg = parseBooleanToInt(useFlg);
    return {
      'id': id,
      'stamp_id': stampId,
      'stamp_date': toDate,
      'stamp_time': toTime,
      'useflg': stampUseFlg,
      'created_at': createdAt.toString()
    };
  }

  @override
  String toString() {
    return 'Stamp{id: $id, stamp_id: $stampId stamp_date: $getDate, stamp_time: $getTime, useFlg: $useFlg, created_at: $createdAt}';
  }

  // テーブル作成
  // join関数でデータベースのパスを設定
  // static Future<Database> get database async {
  //   final Future<Database> _database = openDatabase(
  //     join(await getDatabasesPath(), 'stamp_database.db'),
  //     onUpgrade: (Database db, int oldVersion, int newVersion) {
  //       return db.execute("CREATE TABLE $_tableName ("
  //           "id TEXT PRIMARY KEY,"
  //           "stamp_id TEXT,"
  //           "stamp_date TEXT,"
  //           "stamp_time TEXT,"
  //           "useflg INTEGER,"
  //           "created_at TEXT"
  //           ")");
  //     },
  //     version: 1,
  //   );
  //   return _database;
  // }
}
