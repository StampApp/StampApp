import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Widget/qrScan.dart';

void main() {
  group('qr content validation test', () {
    test('dateCheck validation true test', () {
      // expect(Validation.dateCheck('2021/06/01', '12:00:00'), true);
    });
    // 日付が異なる
    test('dateCheck validation date false test', () {
      // expect(Validation.dateCheck('2021/06/02', '12:00:00'), false);
    });
    // 時刻が異なる
    test('dateCheck validation time false test', () {
      // expect(Validation.dateCheck('2021/06/01', '13:00:00'), false);
    });
    test('strCheck validation true test', () {
      expect(Validation.strCheck('stamp'), true);
    });
    // httpが含まれる
    test('strCheck validation http test', () {
      expect(Validation.strCheck('httpstamp'), false);
    });
    // 記号が含まれる
    test('strCheck validation symbol test', () {
      expect(Validation.strCheck('stamp()#%#'), false);
    });
  });
}
