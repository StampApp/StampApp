import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Widget/qrScan.dart';

void main() {
  group('qr content validation test', () {
    test('dateCheck validation true test', () {
      expect(Validation.dateCheck('2021/06/01', '12:00:00'), true);
    });
    test('dateCheck validation date false test', () {
      expect(Validation.dateCheck('2021/06/02', '12:00:00'), false);
    });
    test('dateCheck validation time false test', () {
      expect(Validation.dateCheck('2021/06/01', '13:00:00'), false);
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
