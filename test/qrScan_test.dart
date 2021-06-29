import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Util/enumCheckString.dart';
import 'package:stamp_app/Util/validation.dart';

void main() {
  group('qr content validation test', () {
    final String stampCheckString = CheckString.ok.checkStringValue;
    //QRの日付が今の日付より前
    test('dateCheck validation true test', () {
      expect(Validation.dateCheck('2021/06/11 12:00:00'), true);
    });
    // QRの日付が今の日付より後
    test('dateCheck validation date false test', () {
      expect(Validation.dateCheck('2021/07/02 12:00:00'), false);
    });
    //checkStringValueの内容が含まれる
    test('strCheck validation true test', () {
      expect(Validation.strCheck(stampCheckString), true);
    });
    // httpが含まれる
    test('strCheck validation http test', () {
      expect(Validation.strCheck('http' + stampCheckString), false);
    });
    // 記号が含まれる
    test('strCheck validation symbol test', () {
      expect(Validation.strCheck(stampCheckString + '()#%#'), false);
    });
  });
}
