# 各バージョン  
Andoroid Studio 3.6.3 , 4.0.1  

Flutter 2.0.5  

Dart 2.12.3

# AndoroidStudioでの実行方法
1. Flutterのインストール  
2. Flutterを任意のフォルダに解凍、環境変数のPathを通す。（\Flutter\bin\まで)  
3. コマンドラインでの`flutter docter` を実行。(`Flutter docter` 環境チェックしてくれるコマンド　[X],[!]　が表示されている箇所は問題あり
4. AndoroidStudoのプラグインにFlutterをインストール
5. プロジェクトをクローン  
6. エミュを作成する際は \andoroid\app\buid.gradle のtargetsdkVersion,minSdkVersionに注意して作成する
   エミュがもともと作成されている場合はVersionを書き換える  
7. 実行(実機の際は特にエラーなし)  


<br>

# 詰まった点  
- 項目4のコマンドを実行した際 Andoroid toolchain の項目がエラーの場合が多い  
コマンドで `flutter docter --andoroid-licenses` を実行     <br>`Android sdkmanager tool not found（c:\~）` が発生した場合<br>
1. toolの最新をDL、解凍。toolというファイルをエラーに書いてあるパスに置く。
2. もう一度 `--andoroid-licenses`　を実行
3. `7of 7 SDK package licenses not accepted. 100% Computing updates...Review licenses that have not been accepted (y/N)?`が出たら7回　y を押して実行


- `JAVA_HOME is set to invalid directory c:\(中略)\bin`　が出た場合<br>
システムまたはユーザーの環境変数の中からJAVA_HOMEを探し出して後ろの「\bin」を削除する
        
    
- `Exception in thread "main" java.lang.~` から始まるjava関係のエラーが起こった場合
        AndoroidStudioのToolsからAndoroid SDK Command-line toolsを新規追加する
    


- AndoroidStudioでのエミュの作成時に起きたエラー<br>
    HAXMのインストールの際、Hyper-Vを有効にするとアンドロイドスタジオのHAXMインストールが失敗する


# 参考文献
[Windows + VSCodeでFlutter環境作成](https://nekodeki.com/windows-vscode%E3%81%A7flutter%E7%92%B0%E5%A2%83%E4%BD%9C%E6%88%90/)

[Flutter始めようとしたらエラー出た。Android license status unknown.](https://qiita.com/nemui-fujiu/items/47b6cae9e2763a96325c)
                 