import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/checkIsMaxStamps.dart';

void main() {
  group('checkIsMaxStamps test', () {
    //第一引数(スタンプ数) + 1が第二引数(スタンプ上限数)以上だったらtrue、それ以外はfalse
    test("checkIsMaxStamps(2, 3) true test", () {
      expect(checkIsMaxStamps(2, 3), true);
    });

    test("checkIsMaxStamps(3, 3) true test", () {
      expect(checkIsMaxStamps(3, 3), true);
    });

    //第二引数が0だったら必ずfalse
    test("checkIsMaxStamps(3, 0) false test", () {
      expect(checkIsMaxStamps(3, 0), false);
    });

    test("checkIsMaxStamps(1, 3) false test", () {
      expect(checkIsMaxStamps(1, 3), false);
    });
  });
}
