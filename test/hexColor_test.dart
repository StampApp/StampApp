import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Widget/HexColor.dart';

void main() {
  group('HexColor関数 Test: ', () {
    //#有り無しで挙動が変わらない
    //hashCodeにして同じものか確認
    test("引数が 00C2FF の場合の返り値", () {
      expect(HexColor('00C2FF').hashCode,
          Color(int.parse("FF00C2FF", radix: 16)).hashCode);
    });

    test("引数が #00C2FF の場合の返り値", () {
      expect(HexColor('#00C2FF').hashCode,
          Color(int.parse("FF00C2FF", radix: 16)).hashCode);
    });

    //#無しで6文字以外が入ってきたらエラー
    test("引数が 00C2FFAAAA の場合の返り値 -> throw Exception", () {
      expect(() => HexColor('00C2FFAAAA'), throwsA(isA<HexException>()));
    });

    test("引数が #00C2FFAAAA の場合の返り値 -> throw Exception", () {
      expect(() => HexColor('#00C2FFAAAA'), throwsA(isA<HexException>()));
    });
  });
}
