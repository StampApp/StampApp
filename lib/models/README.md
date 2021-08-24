## model について

このディレクトリにはスタンプアプリ内で使用しているモデルが入っています。

## stamp.dart について

スタンプ情報の model です。

#### 定義

String id 　一意の ID  
String data 　スタンプのデータ(現在は画像データが入っています)  
DateTime getDate 　スタンプの取得日  
DateTime getTime 　スタンプの取得時間  
String stampNum 　スタンプの数  
bool useFlg 　使用済みフラグ  
DateTime? createdAt 　スタンプが押された時間  
DateTime? deletedAt 　削除日時

#### メソッド

Map<String, dynamic> toMap()  
Stamp 型から Map 型に変換します。  
記述例  
stamp.toMap();

String toString()  
スタンプの情報を全て文字列に変換します。  
記述例  
stamp.toString();

## stampLogs.dart について

スタンプの取得履歴の model です。

#### 定義

String id 　一意の ID  
String stampId 　上記 id とは別のスタンプの ID  
DateTime getDate 　スタンプの取得日  
DateTime getTime 　スタンプの取得時間  
String stampNum 　スタンプの数  
bool useFlg 　使用済みフラグ

#### メソッド

Map<String, dynamic> toMap()  
StampLogs 型から Map 型に変換します。  
記述例  
stampLogs.toMap();

String toString()  
スタンプの情報を全て文字列に変換します。  
'Stamp{id: [id], stamp_id: [stampId], stamp_date: [getDate] ~~ deleted_at: [deletedAt]}';  
という形式の文字列になります。  
記述例  
stampLogs.toString();
