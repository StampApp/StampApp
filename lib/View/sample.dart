/* サンプル
軽い用語？集（大雑把な説明なのでイメージ程度でしか書いてないので詳しくは自分で調べてください）
* Widgetとはコンポーネント(部品)的なものというイメージ
* Stateとは値を変更すると動的に値が切り替わる変数というイメージ
* StatelessWidgetとは単語のままでState lessなWidget、Stateを使わないWidgetはこれで定義する
* StatefulWidgetとは上記の逆でStateを使うWidgetはこれで定義する
* Propsとは親から子に値を受け渡すための値
*/
import 'package:flutter/material.dart';

class SamplePage extends StatefulWidget {
  // コンストラクタで値を受け取るのと同じでいわゆるpropsのような使い方をする
  SamplePage({Key key, this.title}) : super(key: key);
  final String title;

  // 生成したStateをMyPageで使えるように
  @override
  _SamplePageState createState() => _SamplePageState();
}

// state（動的に変化する変数）を生成する
class _SamplePageState extends State<SamplePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // stateを更新
      _counter++;
    });
  }

  void _qrNavigate() {
    Navigator.of(context).pushNamed('/qrReader');
  }

  @override
  Widget build(BuildContext context) {
    // Scaffoldは画面構成の基本Widget
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.green,
              margin: EdgeInsets.fromLTRB(10, 20, 30, 40),
              transform: Matrix4.rotationZ(0.1),
              child: Text('Stamp App',
                style: TextStyle(
                  fontSize: 32.0,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 4.0,
                ),
              ),
            ),
            Text(
              '右下のボタンのクリック回数:',
            ),
            Container(
              child: Text(
                // Stateを呼び出している
                '$_counter' + '回',
                style: Theme.of(context).textTheme.headline4,
              ),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            ),
            RaisedButton(
              child: Text('QRコードリーダーを起動'),
              // color: Colors.white,
              elevation: 16,
              shape: Border(
                top: BorderSide(color: Colors.red),
                left: BorderSide(color: Colors.blue),
                right: BorderSide(color: Colors.yellow),
                bottom: BorderSide(color: Colors.green),
              ),
              splashColor: Colors.purpleAccent,
              onPressed: _qrNavigate
            )
          ],
        ),
      ),
      // Googleのサービスでよくある右下にある丸いボタン（フローティングボタン）
      floatingActionButton: FloatingActionButton(
        // onPressed（ボタン押下時に数字を増やす）
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
