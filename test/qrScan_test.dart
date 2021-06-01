import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Widget/qrScan.dart';

void main() {
  group('qr content validation test', () {
    test('dateCheck validation test', () {
      expect(Validation.dateCheck('2021/06/01'), true);
    });

    test('strCheck validation test', () {
      expect(Validation.strCheck('stamp'), true);
    });

  });
}
