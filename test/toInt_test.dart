import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Util/toInt.dart';

void main() {
  group('BooleanをInt、IntをBooleanにパースする関数 Test: ', () {
    test('trueを0に変換する -> 0', () {
      expect(parseBooleanToInt(true), 0);
    });
    test('falseを1に変換する -> 1', () {
      expect(parseBooleanToInt(false), 1);
    });
    test('0をtrueに変換する -> true', () {
      expect(parseIntToBoolean(0), true);
    });
    test('1をfalseに変換する -> false', () {
      expect(parseIntToBoolean(1), false);
    });
  });
}
