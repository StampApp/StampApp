# model について

このディレクトリにはスタンプアプリ内で使用しているモデルが入っています。

### stamp.dart について

スタンプ情報の model です。  
スタンプ一覧に表示される、QR コードで取得したスタンプの情報です。

### 定義

`String id` 　一意の ID  
`String data` 　スタンプのデータ(現在は画像データが入っています)  
`DateTime getDate` 　スタンプの取得日  
`DateTime getTime` 　スタンプの取得時間  
`String stampNum` 　スタンプの数  
`bool useFlg` 　使用済みフラグ  
`DateTime? createdAt` 　スタンプが押された時間  
`DateTime? deletedAt` 　削除日時

#### メソッド

// Stamp 型から Map 型に変換します。
Map<String, dynamic> toMap();

// 記述例
stamp.toMap();

// Map 型のものを String 型に変換します。
String toString();

// 記述例
stamp.toString();

/_
`Stamp{id: [id], stamp_id: [stampId], stamp_date: [getDate], stamp_time: [getTime], stamp_num: [stampNum], useflg: [useFlg], created_at: [createdAt], deleted_at: [deletedAt]}`  
という形式の文字列になります。
_/

---

### stampLogs.dart について

スタンプの取得履歴の model です。  
スタンプ履歴画面で表示される、スタンプの取得や利用の履歴の情報です。

#### 定義

`String id` 　一意の ID  
`String stampId` 　上記 id とは別のスタンプの ID  
`DateTime getDate` 　スタンプの取得日  
`DateTime getTime` 　スタンプの取得時間  
`bool useFlg` 　使用済みフラグ

#### メソッド

###### toMap()

StampLogs 型から Map 型に変換します。

```Dart
Map<String, dynamic> toMap()
```

記述例

```Dart
stampLogs.toMap();
```

###### toString()

スタンプの情報を全て文字列に変換します。

```Dart
String toString()
```

記述例

```Dart
stampLogs.toString();
```

`'Stamp{id: [id], stamp_id: [stampId], stamp_date: [getDate], stamp_time: [getTime], useflg: [useFlg], created_at: [createdAt]}'`  
という形式の文字列になります。
