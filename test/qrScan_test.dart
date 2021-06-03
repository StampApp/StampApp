import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Widget/qrScan.dart';

void main() {
  group('qr content validation test', () {
    test('dateCheck validation true test', () {
      expect(Validation.dateCheck('2021/06/01'), true);
    });
    test('dateCheck validation false test', () {
      expect(Validation.dateCheck('2021/06/02'), false);
    });
    test('strCheck validation true test', () {
      expect(Validation.strCheck('stamp'), true);
    });
    test('strCheck validation http test', () {
      expect(Validation.strCheck('httpstamp'), false);
    });
    test('strCheck validation symbol test', () {
      expect(Validation.strCheck('stamp()#%#'), false);
    });
  });
}
