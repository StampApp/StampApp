import 'package:intl/intl.dart';

String toDateOrTime(DateTime datetime, String dateType) {
  if (dateType == "date") {
    return DateFormat('MM/dd/yyyy').format(datetime);
  } else if (dateType == "time") {
    return DateFormat('HH:mm:ss').format(datetime);
  }
}
