import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/checkIsMaxStamps.dart';

void main() {
  group('checkIsMaxStamps test', () {
    test("checkIsMaxStamps true test", () {
      expect(checkIsMaxStamps(2, 3), true);
    });

    test("checkIsMaxStamps true test", () {
      expect(checkIsMaxStamps(3, 3), true);
    });

    test("checkIsMaxStamps false test", () {
      expect(checkIsMaxStamps(3, 0), false);
    });

    test("checkIsMaxStamps false test", () {
      expect(checkIsMaxStamps(1, 3), false);
    });
  });
}
