import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stamp_app/Util/Enums/enumDateType.dart';

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

String dateFormat(createdAt) {
  initializeDateFormatting('ja');
  String data = DateFormat.yMMMEd('ja').format(createdAt).toString() + "　";
  data += DateFormat.jms('ja').format(createdAt).toString();
  return data;
}