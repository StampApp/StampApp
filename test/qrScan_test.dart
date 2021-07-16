import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Constants/setting.dart';
import 'package:stamp_app/Util/Enums/enumCheckString.dart';
import 'package:stamp_app/Util/validation.dart';

void main() {
  group('QRコードのContentのValidation Test: ', () {
    final String stampCheckString = CheckString.ok.checkStringValue;
    final List<String> imagePaths = [Setting.STAMP_FLOWER, Setting.NONE_IMG];
    //QRの日付が今の日付より前
    test('QRの日付が今の日付より前 -> true', () {
      expect(Validation.dateCheck('2021/06/11 12:00:00'), true);
    });
    // QRの日付が今の日付より後
    test('QRの日付が今の日付より後 -> false', () {
      expect(Validation.dateCheck('2022/07/02 12:00:00'), false);
    });
    //checkStringValueの内容が含まれる
    test('checkStringValueの内容[$stampCheckString]が含まれる -> true', () {
      expect(Validation.strCheck(stampCheckString), true);
    });
    // httpが含まれる
    test('httpという文字が含まれる -> false', () {
      expect(Validation.strCheck('http' + stampCheckString), false);
    });
    // 記号が含まれる
    test('記号が含まれる -> test', () {
      expect(Validation.strCheck(stampCheckString + '()#%#'), false);
    });
    // パスの先頭に./が含まれておりファイルが存在する
    test('パスの先頭に./が含まれておりファイルが存在する -> true', () {
      expect(
          Validation.pathCheck(
              "./assets/images/stamp/flower-4.png", imagePaths),
          true);
    });
    // パスの先頭に/が含まれておりファイルが存在する
    test('パスの先頭に/が含まれておりファイルが存在する -> true', () {
      expect(
          Validation.pathCheck("/assets/images/stamp/flower-4.png", imagePaths),
          true);
    });
    // ファイルが存在する
    test('ファイルが存在する -> true', () {
      expect(Validation.pathCheck(Setting.STAMP_FLOWER, imagePaths), true);
    });
    // ファイルが存在しない
    test('ファイルが存在しない -> false', () {
      expect(
          Validation.pathCheck("assets/images/stamp/test", imagePaths), false);
    });
    // 文字列が0文字
    test('文字列が0文字 -> false', () {
      expect(Validation.pathCheck("", imagePaths), false);
    });
  });
}
