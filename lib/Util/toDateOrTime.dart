import 'package:intl/intl.dart';
import 'package:stamp_app/Util/Enums/enumDateType.dart';

// datetime からstringへの変換
String formatDateTimeToString(DateTime datetime, EnumDateType dateType) {
  switch (dateType) {
    case EnumDateType.date:
      return DateFormat('yyyy-MM-dd').format(datetime);
    case EnumDateType.time:
      return DateFormat('HH:mm:ss').format(datetime);
    default:
      return DateFormat('yyyy-MM-dd').format(datetime);
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
