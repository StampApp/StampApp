// 読み込んだQRを検証するクラス
import 'package:intl/intl.dart';
import 'package:stamp_app/Util/Enums/enumCheckString.dart';

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

  static bool pathCheck(String path, List<String> imagePaths) {
    try {
      String relative = path.substring(0, 2);
      path = relative == "./"
          ? path.substring(2)
          : relative[0] == "/"
              ? path.substring(1)
              : path;
      return imagePaths.contains(path) ? true : false;
    } catch (e) {
      return false;
    }
  }
}
