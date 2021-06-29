// 読み込んだQRを検証するクラス
import 'package:intl/intl.dart';
import 'package:stamp_app/Util/enumCheckString.dart';

class Validation {
  static final String stampCheckString = CheckString.ok.checkStringValue;
  static bool dateCheck(datetime) {
    DateTime verificationDate =
        DateFormat("yyyy/MM/dd HH:mm:ss").parseStrict(datetime);
    DateTime now = DateTime.now();

    if (now.isBefore(verificationDate)) return false;
    return true;
  }

  static bool strCheck(String content) {
    // 記号・半角を含まない
    if (RegExp(r'^(?=.*[!-/:-@[-`{-~]).*$').hasMatch(content)) return false;
    if (!content.contains(stampCheckString)) return false;
    if (content.contains('http')) return false;
    return true;
  }
}
