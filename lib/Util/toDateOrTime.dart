import 'package:intl/intl.dart';
import 'package:stamp_app/Util/enumDateType.dart';

String toDateOrTime(DateTime datetime, String dateType) {
  if (dateType == enumDateType.date.toString()) {
    return DateFormat('MM/dd/yyyy').format(datetime);
  } else if (dateType == enumDateType.time.toString()) {
    return DateFormat('HH:mm:ss').format(datetime);
  }
}
