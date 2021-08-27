import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/toInt.dart';
import 'package:stamp_app/Util/Enums/enumDateType.dart';

class StampLogs {

  /// モデル定義
  final String id;
  final String stampId; // スタンプID
  final DateTime getDate; // 取得日
  final DateTime getTime; // 取得時間
  final bool useFlg; // 使用済みフラグ
  final DateTime? createdAt; // スタンプが押された時間

  /// required thisは引数を必須引数にするかつstampクラスのインスタンスということを指す
  /// thisはstampクラスのインスタンスということを指す
  StampLogs({
    required this.id,
    required this.stampId,
    required this.getDate,
    required this.getTime,
    required this.useFlg,
    this.createdAt
  });

  /// StampからMap型に変換
  /// カラム名に対応する必要あり
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

  /// スタンプの情報を全て文字列に変換する
  @override
  String toString() {
    return 'Stamp{id: $id, stamp_id: $stampId stamp_date: $getDate, stamp_time: $getTime, useFlg: $useFlg, created_at: $createdAt}';
  }
}
