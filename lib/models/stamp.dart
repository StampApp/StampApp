import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/toInt.dart';
import 'package:stamp_app/Util/Enums/enumDateType.dart';

class Stamp {

  ///モデル定義
  final String id;
  final String data; // スタンプ情報
  final DateTime getDate; // 取得日
  final DateTime getTime; // 取得時間
  final String stampNum; // スタンプの数
  final bool useFlg; // 使用済みフラグ
  final DateTime? createdAt; // スタンプが押された時間
  final DateTime? deletedAt; // 削除日時

  /// required thisは引数を必須引数にするかつstampクラスのインスタンスということを指す
  /// thisはstampクラスのインスタンスということを指す
  Stamp({
    required this.id,
    required this.data,
    required this.getDate,
    required this.getTime,
    required this.stampNum,
    required this.useFlg,
    this.createdAt,
    this.deletedAt
  });

  /// StampからMap型に変換
  /// カラム名に対応する必要あり
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

  /// スタンプの情報を全て文字列に変換する
  @override
  String toString() {
    return 'Stamp{id: $id, data: $data, stamp_date: $getDate, stamp_time: $getTime, stamp_num: $stampNum, useflg: $useFlg, created_at: $createdAt, deleted_at: $deletedAt}';
  }
}
