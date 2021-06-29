import 'package:intl/intl.dart';
import 'package:stamp_app/Util/enumDateType.dart';

// datetime からstringへの変換
String formatDateTimeToString(DateTime datetime, EnumDateType dateType) {
  switch (dateType) {
    case EnumDateType.date:
      return DateFormat('yyyy-MM-dd').format(datetime);
      break;
    case EnumDateType.time:
      return DateFormat('HH:mm:ss').format(datetime);
      break;
    default:
      return DateFormat('yyyy-MM-dd').format(datetime);
      break;
  }
  // if (dateType == enumDateType.date.toString()) {
  //   return DateFormat('yyyy-MM-dd').format(datetime);
  // } else if (dateType == enumDateType.time.toString()) {
  //   return DateFormat('HH:mm:ss').format(datetime);
  // }
}

// stringからdatetimeへの変換
DateTime formatStringToDateTime(String strDateTime, EnumDateType dateType) {
  switch (dateType) {
    case EnumDateType.date:
      DateFormat dateFormatter = DateFormat("yyyy-MM-dd");
      return dateFormatter.parseStrict(strDateTime);
      break;
    case EnumDateType.time:
      DateFormat dateFormatter = DateFormat("HH:mm:ss");
      return dateFormatter.parseStrict(strDateTime);
      break;
    default:
      DateFormat dateFormatter = DateFormat("yyyy-MM-dd");
      return dateFormatter.parseStrict(strDateTime);
      break;
  }
}
