import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/toInt.dart';
import 'package:stamp_app/Util/enumDateType.dart';

void main() {
  group('stamp test', () {
    test('toDateOrTime toDate test', () {
      expect(
        toDateOrTime(DateTime(2021, 6, 3, 16, 25, 10, 10, 10),
            enumDateType.date.toString()),
        '2021/06/03',
      );
    });
    test('toDateOrTime toTime test', () {
      expect(
        toDateOrTime(DateTime(2021, 6, 3, 16, 25, 10, 10, 10),
            enumDateType.time.toString()),
        '16:25:10',
      );
    });
    test('toInt true test', () {
      expect(toInt(true), 0);
    });
    test('toInt false test', () {
      expect(toInt(false), 1);
    });
  });
}
