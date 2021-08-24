import 'package:intl/intl.dart';
import 'package:stamp_app/Util/Enums/enumCheckString.dart';

/// QRコードが現時刻より昔だった場合trueを返す
///
/// [dateCheck],引数QRコードの時間　戻り値boolean
/// [verificationDate]DateTime型　受け取った時刻をyyyy/MM/dd HH:mm:ss形式に
/// [now]DateTime型　現時刻
///
class Validation {
  static final String stampCheckString = CheckString.ok.checkStringValue!;
  static bool dateCheck(datetime) {
    DateTime verificationDate =
        DateFormat("yyyy/MM/dd HH:mm:ss").parseStrict(datetime);
    DateTime now = DateTime.now();

    if (now.isBefore(verificationDate)) return false;
    return true;
  }


/// 正規表現チェック
///
/// [strCheck] 引数[content]string 戻り値boolean
///
///```
/// [content]1(正規表現)
///          2([stampCheckString]の内容が含まれない)
///          3(httpの頭文字)
/// [content]が上記の場合false
///```
  static bool strCheck(String content) {
    // 記号・半角を含まない
    if (RegExp(r'^(?=.*[!-/:-@[-`{-~]).*$').hasMatch(content)) return false;
    if (!content.contains(stampCheckString)) return false;
    if (content.contains('http')) return false;
    return true;
  }


/// ファイルがあるか確認
///
/// [pathCheck]引数[path][imagePaths] 戻り値boolean
/// [path]String型　
/// [imagePaths]string型のリスト
///
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
