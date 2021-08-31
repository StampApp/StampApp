import 'dart:ui';

/// アプリで使用したい色をカラーコードで指定できる
///
/// [_getColorFromHex], 引数 [hexColor]string型カラーコード 
///                     戻り値 整数のカラーコード
///
/// [parse],　          引数 [hexColor]string型  [radix]string型 基数(数学的記数法の底)
///         　          戻り値 [hexColor]を解析した整数
///
class HexException implements Exception {
  String cause;
  HexException(this.cause);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    try {
      if (hexColor.length == 6) {
        hexColor = 'FF' + hexColor;
        return int.parse(hexColor, radix: 16);
      } else {
        throw new HexException('The characters are not 6 characters.');
      }
    } on HexException {
      // print('HexException catch ${e.cause}');
      rethrow;
    } catch (e) {
      // print('catch:$e');
      rethrow;
    }
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
