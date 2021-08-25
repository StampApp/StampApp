# Test について

GithubActionによる関数群のテストを行うためのロジックが記載されたファイルです。  
テストファイル名には決まりがあり`テストしたい関数名_test.dart`のような形になっています。

## checkIsMaxStamps_test

### テスト

スタンプの最大個数を判断する関数  
`checkIsMaxStamps(int successStampLen, int maxStamp)`

### テスト内容

`expect(checkIsMaxStamps(2, 3), true)`

- 引数が (2, 3) -> true

`expect(checkIsMaxStamps(3, 3), true);`

- 引数が (3, 3) -> true

`expect(checkIsMaxStamps(3, 0), false);`

- 引数が (3, 0) -> false

`expect(checkIsMaxStamps(1, 3), false);`

- 引数が (1, 3) -> false


## dbInterface_test.dart

### テスト

LocalのSQLiteと通信を行うクラス

### テスト内容

`DbInterface.select`

- DBInterfaceのSelectを利用して取ってきたが元データと同一か比較 -> true

`DbInterface.allSelect`

- DBInterfaceのallSelectを利用して取ってきたデータが元データと同一か比較 -> true

`DbInterface.update`

- DBInterfaceのupdateを利用して更新したデータが更新の元となったデータと同一か比較 -> true

`DbInterface.delete`

- 1件のみ入っているデータをDbInterfaceのdelete利用して削除し、データの件数が0になったか比較 -> true

`DbInterface.allDelete`

- 複数件のデータをDbInterfaceのallDelete利用して削除し、データの件数が0になったか -> true


## hexColor_test.dart

### テスト

HexColorコードに変換するクラス  
`HexColor(string colorCode)`

### テスト内容

`expect(HexColor('00C2FF').hashCode, Color(int.parse("FF00C2FF", radix: 16)).hashCode);`

- 引数が 00C2FF の場合の返り値 -> 正常なカラーコード

`expect(HexColor('#00C2FF').hashCode, Color(int.parse("FF00C2FF", radix: 16)).hashCode);`

- 引数が #00C2FF の場合の返り値 -> 正常なカラーコード

`expect(() => HexColor('00C2FFAAAA'), throwsA(isA<HexException>()));`

- 引数が 00C2FFAAAA の場合の返り値 -> HexException

`expect(() => HexColor('#00C2FFAAAA'), throwsA(isA<HexException>()));`

- 引数が #00C2FFAAAA の場合の返り値 -> HexException

## qrScan_test.dart

### テスト

QRコードのContentのバリデーションテストを行うクラス  
`stampCheckString`とはQRの内容が正しいか整合性をとるための値が格納されている  


### テスト内容

`expect(Validation.dateCheck('2021/06/11 12:00:00'), true);`

- QRの日付が今の日付より前 -> true

`expect(Validation.dateCheck('2022/07/02 12:00:00'), false);`

- QRの日付が今の日付より後 -> false

`expect(Validation.strCheck(stampCheckString), true);`

- checkStringValueの内容[$stampCheckString]が含まれる -> true

`expect(Validation.strCheck('http' + stampCheckString), false);`

- httpという文字が含まれる(不正文字判定) -> false

`expect(Validation.strCheck(stampCheckString + '()#%#'), false);`

- 記号が含まれる -> test

`expect(Validation.pathCheck("./assets/images/stamp/flower-4.png", imagePaths), true);`

- パスの先頭に./が含まれておりファイルが存在する -> true

`expect(Validation.pathCheck("/assets/images/stamp/flower-4.png", imagePaths), true);`

- パスの先頭に/が含まれておりファイルが存在する -> true

`expect(Validation.pathCheck(Setting.STAMP_FLOWER, imagePaths), true);`

- ファイルが存在する -> true

`expect(Validation.pathCheck("assets/images/stamp/test", imagePaths), false);`

- ファイルが存在しない -> false

`expect(Validation.pathCheck("", imagePaths), false);`

- 文字列が0文字 -> false

## toDateOrTime_test.dart

### テスト

スタンプ用の日付、時間をパースする関数  
`formatDateTimeToString(DateTime datetime, EnumDateType dateType)`  
`formatStringToDateTime(String strDateTime, EnumDateType dateType)`

### テスト内容

`expect(formatDateTimeToString(DateTime(2021, 6, 3, 16, 25, 10, 10, 10), EnumDateType.date),'2021-06-03');`

- DateTypeがDateなのでDateフォーマットに変換 -> 正常な値

`expect(formatDateTimeToString(DateTime(2021, 6, 3, 16, 25, 10, 10, 10), EnumDateType.time), '16:25:10');`

- DateTypeがTimeなのでTimeフォーマットに変換 -> 正常な値


## toInt_test.dart

### テスト

BooleanをInt、IntをBooleanにパースする関数  
`parseBooleanToInt(bool deletedFlg)`  
`parseIntToBoolean(int deletedFlg)`

### テスト内容

`expect(parseBooleanToInt(true), 1);`

- trueを数値に変換する -> 1

`expect(parseBooleanToInt(false), 0);`

- falseを数値に変換する -> 0

`expect(parseIntToBoolean(1), true);`

- 1をbooleanに変換する -> true

`expect(parseIntToBoolean(0), false);`

- 0をbooleanに変換する -> false