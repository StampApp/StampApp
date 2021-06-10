import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stamp_app/Widget/HexColor.dart';

void main() {
  group('HexColor test', () {
    //#有り無しで挙動が変わらない
    //hashCodeにして同じものか確認
    test("HexColor('00C2FF') return Color", () {
      expect(HexColor('00C2FF').hashCode,
          Color(int.parse("FF00C2FF", radix: 16)).hashCode);
    });

    test("HexColor('#00C2FF') return Color", () {
      expect(HexColor('#00C2FF').hashCode,
          Color(int.parse("FF00C2FF", radix: 16)).hashCode);
    });

    //#無しで6文字以外が入ってきたらエラー
    test("HexColor('00C2FFAAAA') throw Exception", () {
      expect(() => HexColor('00C2FFAAAA'), throwsA(isA<HexException>()));
    });

    test("HexColor('#00C2FFAAAA') throw Exception", () {
      expect(() => HexColor('#00C2FFAAAA'), throwsA(isA<HexException>()));
    });
  });
}
