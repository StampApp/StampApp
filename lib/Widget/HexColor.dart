//色をカラーコードで指定するためのクラス
import 'dart:ui';

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
    } on HexException catch (e) {
      print('HexException catch ${e.cause}');
      rethrow;
    } catch (e) {
      print('catch:$e');
      rethrow;
    }
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
