import 'package:intl/intl.dart';

class TimeConvert {
  DateTime _dt; // 日付データ
  String _dateType; // 日付データ型
  String _sdt; // 日付データの返り値
  TimeConvert(DateTime dt, String dateType) {
    this._dt = dt;
    this._dateType = dateType;
    if (dateType == "date") {
      this._sdt = DateFormat('MM/dd/yyyy').format(dt);
    } else if (dateType == "time") {
      this._sdt = DateFormat('HH:mm:ss').format(dt);
    }
  }
  // Getter
  DateTime get dt => _dt;
  String get dateType => _dateType;
  String get sdt => _sdt;
}
