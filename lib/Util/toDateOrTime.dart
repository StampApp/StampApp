import 'package:intl/intl.dart';

String toDateOrTime(DateTime datetime, String dateType) {
  String stringDateOrTime;
  if (dateType == "date") {
    return stringDateOrTime = DateFormat('MM/dd/yyyy').format(datetime);
  } else if (dateType == "time") {
    return stringDateOrTime = DateFormat('HH:mm:ss').format(datetime);
  }
}
