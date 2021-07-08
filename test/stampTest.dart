import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/toInt.dart';
import 'package:stamp_app/Util/enumDateType.dart';

void main() {
  group('stamp test', () {
    test('toDateOrTime toDate test', () {
      expect(
        formatDateTimeToString(
            DateTime(2021, 6, 3, 16, 25, 10, 10, 10), EnumDateType.date),
        '2021/06/03',
      );
    });
    test('toDateOrTime toTime test', () {
      expect(
        formatDateTimeToString(
            DateTime(2021, 6, 3, 16, 25, 10, 10, 10), EnumDateType.time),
        '16:25:10',
      );
    });
    test('toInt true test', () {
      expect(parseBooleanToInt(true), 0);
    });
    test('toInt false test', () {
      expect(parseBooleanToInt(false), 1);
    });
  });
}
