import 'package:intl/intl.dart';

class TimeConvert {
  DateTime dt; // 日付データ
  String dateType; // 日付データ型
  String sdt; // 日付データの返り値
  TimeConvert(this.dt, this.dateType) {
    if (dateType == "date") {
      this.sdt = DateFormat('MM/dd/yyyy').format(dt);
    } else if (dateType == "time") {
      this.sdt = DateFormat('HH:mm:ss').format(dt);
    }
  }
}
