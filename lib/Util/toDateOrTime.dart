import 'package:intl/intl.dart';
import 'package:stamp_app/Util/enumDateType.dart';

String toDateOrTime(DateTime datetime, String dateType) {
  if (dateType == enumDateType.date.toString()) {
    return DateFormat('yyyy/MM/dd').format(datetime);
  } else if (dateType == enumDateType.time.toString()) {
    return DateFormat('HH:mm:ss').format(datetime);
  }
}

DateTime dateFormatParse(String strDateTime, String dateType) {
  if (dateType == enumDateType.date.toString()) {
    DateFormat dateFormatter = DateFormat("y/M/d");
    return dateFormatter.parseStrict(strDateTime);

  } else if (dateType == enumDateType.time.toString()) {
    DateFormat dateFormatter = DateFormat("HH:mm:ss");
    return dateFormatter.parseStrict(strDateTime);
  }
}