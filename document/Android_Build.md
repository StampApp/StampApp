# 各バージョン

Andoroid Studio 3.6.3 , 4.0.1

Flutter 2.0.5

Dart 2.12.3

# AndoroidStudio での実行方法

1. Flutter のインストール
2. Flutter を任意のフォルダに解凍、環境変数の Path を通す。（\Flutter\bin\まで)
3. コマンドラインでの`flutter docter` を実行。(`Flutter docter` 環境チェックしてくれるコマンド　[X],[!]　が表示されている箇所は問題あり
4. AndoroidStudo のプラグインに Flutter をインストール
5. プロジェクトをクローン
6. エミュを作成する際は \andoroid\app\buid.gradle の targetsdkVersion,minSdkVersion に注意して作成する
   エミュがもともと作成されている場合は Version を書き換える
7. 実行(実機の際は特にエラーなし)

<br>

# 詰まった点

- 項目 4 のコマンドを実行した際 Andoroid toolchain の項目がエラーの場合が多い  
  コマンドで `flutter docter --andoroid-licenses` を実行 <br>`Android sdkmanager tool not found（c:\~）` が発生した場合<br>

1. tool の最新を DL、解凍。tool というファイルをエラーに書いてあるパスに置く。
2. もう一度 `--andoroid-licenses`　を実行
3. `7of 7 SDK package licenses not accepted. 100% Computing updates...Review licenses that have not been accepted (y/N)?`が出たら 7 回　 y を押して実行

- `JAVA_HOME is set to invalid directory c:\(中略)\bin`　が出た場合<br>
  システムまたはユーザーの環境変数の中から JAVA_HOME を探し出して後ろの「\bin」を削除する

- `Exception in thread "main" java.lang.~` から始まる java 関係のエラーが起こった場合
  AndoroidStudio の Tools から Andoroid SDK Command-line tools を新規追加する

- AndoroidStudio でのエミュの作成時に起きたエラー<br>
  HAXM のインストールの際、Hyper-V を有効にするとアンドロイドスタジオの HAXM インストールが失敗する

# 参考文献

[Windows + VSCode で Flutter 環境作成](https://nekodeki.com/windows-vscode%E3%81%A7flutter%E7%92%B0%E5%A2%83%E4%BD%9C%E6%88%90/)

[Flutter 始めようとしたらエラー出た。Android license status unknown.](https://qiita.com/nemui-fujiu/items/47b6cae9e2763a96325c)
