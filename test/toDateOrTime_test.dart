import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Util/toDateOrTime.dart';
import 'package:stamp_app/Util/Enums/enumDateType.dart';

void main() {
  group('スタンプ用の日付、時間をパースする関数 Test: ', () {
    test('DateTypeがDateなのでDateフォーマットに変換', () {
      expect(
        formatDateTimeToString(
            DateTime(2021, 6, 3, 16, 25, 10, 10, 10), EnumDateType.date),
        '2021-06-03',
      );
    });
    test('DateTypeがTimeなのでTimeフォーマットに変換', () {
      expect(
        formatDateTimeToString(
            DateTime(2021, 6, 3, 16, 25, 10, 10, 10), EnumDateType.time),
        '16:25:10',
      );
    });
  });
}
