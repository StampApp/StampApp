import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Util/toInt.dart';

void main() {
  group('BooleanをInt、IntをBooleanにパースする関数 Test: ', () {
    test('trueを1に変換する -> 1', () {
      expect(parseBooleanToInt(true), 1);
    });
    test('falseを0に変換する -> 0', () {
      expect(parseBooleanToInt(false), 0);
    });
    test('1をtrueに変換する -> true', () {
      expect(parseIntToBoolean(1), true);
    });
    test('0をfalseに変換する -> false', () {
      expect(parseIntToBoolean(0), false);
    });
  });
}
