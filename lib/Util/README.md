# Utilとは

プログラミングに役立つパッケージのことで、インポートすることで使用できる。

## checkIsMaxStamps.dartの使い方

引数のスタンプの数を比較する
### import
```dart
import 'package:stamp_app/Util/checkIsMaxStamps.dart';
```
### 使用例
```dart
//第一引数+1が第二引数以上のときtureを返す。
checkIsMaxStamps(2, 3) // -> ture
checkIsMaxStamps(1, 3) // -> false
//第二引数が0のときは必ずfalseを返す。
checkIsMaxStamps(3, 0) // -> false
```

## toDateOrTime.dartの使い方

型の変更や、フォーマットの変更を行う

### import
```dart
import 'package:stamp_app/Util/toDateOrTime.dart';
```
### 使用例
```dart
//[formatDateTimeToString]:時刻型から文字列型へ変換
// 第二引数が[date]の場合は「yyyy-MM-dd」へ変更
formatDateTimeToString(DateTime(2021, 6, 3, 16, 25, 10, 10, 10), EnumDateType.date)
// 第二引数が[time]の場合は「HH:mm:ss」へ変更
formatDateTimeToString(DateTime(2021, 6, 3, 16, 25, 10, 10, 10), EnumDateType.time)

//[formatStringToDateTime]:文字列型から時刻型に変更
// 第一引数[strDateTime]と第二引数[dateType]を受け取り文字列型に変更して返す
formatStringToDateTime(maps[i]['stamp_date'], EnumDateType.date)
formatStringToDateTime(maps[i]['stamp_time'], EnumDateType.time)

//[dateFormat]:年月日表記に変更
//引数[createdAt]を「yyyy年MM月DD日(E) hh:mm:ss」表記に変更
dateFormat(stamp.createdAt)
```
​
## toInt.dartの使い方

​型の変更を行う
### import
```dart
import 'package:stamp_app/Util/toInt.dart';
```
### 使用例
```dart
//[parseBooleanToInt]:boolをintへ変更
//boolがfalseの場合は0に変更する
parseBooleanToInt(false) // -> 0
// boolがtrueの場合は1に変更する
parseBooleanToInt(true) // -> 1

//[parseIntToBoolean]:intをboolへ変更
//intが0の場合はfalseに変更する
parseIntToBoolean(0) // -> false
//intが1の場合はtrueに変更する
parseIntToBoolean(1) // -> ture
```
## validation.dartの使い方
​
時刻チェック、正規表現チェック、ファイル有無のチェックを行う
### import
```dart
import 'package:stamp_app/Util/validation.dart';
```
### 使用例
```dart
//[dateCheck]:QRコードに含まれる時刻のチェック
//QRコードが現時刻より前だった場合trueを返す
Validation.dateCheck('2021/06/11 12:00:00') // -> ture
//QRコードが現時刻より後だった場合falseを返す
Validation.dateCheck('2022/07/02 12:00:00') // -> false

//[strCheck]:正規表現チェック
//checkStringValueの内容が含まれる場合はture
Validation.strCheck(stampCheckString) // -> ture
// httpが含まれる場合はfalse
Validation.strCheck('http' + stampCheckString) // -> false
// 記号が含まれる場合はfalse
Validation.strCheck(stampCheckString + '()#%#') // -> false

//[pathCheck]:ファイルがあるか確認
// パスの先頭に./が含まれておりファイルが存在する場合はtrue
Validation.pathCheck(  "./assets/images/stamp/flower-4.png", imagePaths) // -> ture
// パスの先頭に/が含まれておりファイルが存在する場合はtrue
Validation.pathCheck("/assets/images/stamp/flower-4.png", imagePaths) // -> ture
// ファイルが存在する場合はtrue
Validation.pathCheck(Setting.STAMP_FLOWER, imagePaths) // -> ture
// ファイルが存在しない場合はfalse
Validation.pathCheck("assets/images/stamp/test", imagePaths) // -> false
// 文字列が0文字の場合はfalse
Validation.pathCheck("", imagePaths) // -> false
```
## HexColor.dartの使い方

アプリで使用したい色をカラーコードで指定できる
### import
```dart
import 'package:stamp_app/Widget/HexColor.dart';
```
### 使用例
```dart
//色を指定したいところで使用
color: HexColor('FFFFFF')
```