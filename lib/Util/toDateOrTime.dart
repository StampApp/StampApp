import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stamp_app/Util/Enums/enumDateType.dart';

///時刻型から文字列型へ変換
///
///第二引数が[date]の場合は「yyyy-MM-dd」へ変更
///第二引数が[time]の場合は「HH:mm:ss」へ変更
///
///```
///formatDateTimeToString(DateTime(2021, 6, 3, 16, 25, 10, 10, 10), EnumDateType.date)
///formatDateTimeToString(DateTime(2021, 6, 3, 16, 25, 10, 10, 10), EnumDateType.time)
///```
String formatDateTimeToString(DateTime datetime, EnumDateType dateType) {
  switch (dateType) {
    case EnumDateType.date:
      return DateFormat('yyyy-MM-dd').format(datetime);
    case EnumDateType.time:
      return DateFormat('HH:mm:ss').format(datetime);
    default:
      return DateFormat('yyyy-MM-dd').format(datetime);
  }
}
///文字列型から時刻型に変更
///
///第一引数[strDateTime]と第二引数[dateType]を受け取り文字列型に変更して返す
///
///```
///formatStringToDateTime(maps[i]['stamp_date'], EnumDateType.date)
///formatStringToDateTime(maps[i]['stamp_time'], EnumDateType.time)
///```
DateTime formatStringToDateTime(String strDateTime, EnumDateType dateType) {
  switch (dateType) {
    case EnumDateType.date:
      DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
      return dateFormatter.parseStrict(strDateTime);
    case EnumDateType.time:
      DateFormat dateFormatter = DateFormat('HH:mm:ss');
      return dateFormatter.parseStrict(strDateTime);
    default:
      DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
      return dateFormatter.parseStrict(strDateTime);
  }
}
///年月日表記に変更
///
///引数[createdAt]を「yyyy年MM月DD日(E) hh:mm:ss」表記に変更
///
///```
///dateFormat(stamp.createdAt)
///```
String dateFormat(createdAt) {
  initializeDateFormatting('ja');
  String data = DateFormat.yMMMEd('ja').format(createdAt).toString() + "　";
  data += DateFormat.jms('ja').format(createdAt).toString();
  return data;
}