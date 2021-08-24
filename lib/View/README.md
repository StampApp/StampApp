# View について

この View ディレクトリ下に存在するファイルは画面の見た目及び内部ロジックが書かれたファイルです。

## history.dart

### 見た目

設定内の利用履歴画面

### 関数

`getStampList`

- StampLogs からスタンプの履歴を取得する。
- 引数なし、戻り値`List<StampLogs>`

`getDateList`

- 重複しない Date を satmpList から取得する。
- 引数なし、戻り値`List<StampLogs>`

`pastMonthChange`

- 取得するスタンプの日付条件を変更する。
- 引数`int`、戻り値なし

`deleteLogs`

- 利用履歴の削除を行い画面を再表示する。
- 引数なし、戻り値なし

`setItem`

- ドロップダウンの中身のアイテムを作成する。
- 引数なし、戻り値なし

## home.dart

### 見た目

起動後のホーム画面

### 関数

`asyncGetStampList`

- DB の Stamp から useflg が 0 のデータを取得し stampList に格納する。
- 引数なし、戻り値`Future<List<Stamp>>`

`didPopNext`

- 一度、別の画面に遷移したあとで、再度この画面に戻ってきた時にコールされる。
  stampList と stampListLen の更新を行う。
- 引数なし、戻り値なし

## instructions.dart

### 見た目

設定内の使い方画面

### 関数

`_createCardAnimate`

- アニメーションカード生成
- 引数`String, bool`、戻り値`AnimatedContainer`

## privacyPolicy.dart

### 見た目

設定内のプライバシーポリシー画面

### 関数

特になし

## qrScan.dart

### 見た目

QR スキャン時の画面

### 関数

`_onQRViewCreated`

- QR を読み込みをする。
- 引数`QRViewController`、戻り値なし

`_transitionToNextScreen`

- 読み込んだ QR を検証し結果とともにホーム画面へ遷移する。
- 引数`String, String, String`

`scanValidation`

- QR のデータを検証する。
- 引数`Barcode`、戻り値`ScanResult`

## Setting.dart

### 見た目

設定画面

### 関数

`_useStampCheck`

- スタンプを使用するかの確認画面を出す。
- 引数なし、戻り値`showDialog`

`_useStampDialog`

- スタンプを使用した結果を表示する。
- 引数なし、戻り値`showDialog`

`_useStamp`

- スタンプ数を取得し規定数あった場合使用する。
- 引数なし、戻り値`Stamp`

## terms.dart

### 見た目

設定内の利用規約画面

### 関数

特になし
