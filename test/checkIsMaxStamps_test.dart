import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Util/checkIsMaxStamps.dart';

void main() {
  group('checkIsMaxStamps関数 Test: ', () {
    //第一引数(スタンプ数) + 1が第二引数(スタンプ上限数)以上だったらtrue、それ以外はfalse
    test("引数が (2, 3) -> true", () {
      expect(checkIsMaxStamps(2, 3), true);
    });

    test("引数が (3, 3) -> true", () {
      expect(checkIsMaxStamps(3, 3), true);
    });

    //第二引数が0だったら必ずfalse
    test("引数が (3, 0) -> false", () {
      expect(checkIsMaxStamps(3, 0), false);
    });

    test("引数が (1, 3) -> false", () {
      expect(checkIsMaxStamps(1, 3), false);
    });
  });
}
