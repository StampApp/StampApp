import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class InstructionsPage extends StatefulWidget {
  InstructionsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _InstructionsPageState createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: HexColor('00C2FF'),
        ),

        body: Introduction(),
        ),
      );

  }

  Widget _menuItem(String title, Icon icon, [VoidCallback tap]) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ],
          )),
      //リストクリック時実行部分
      onTap: () {
        if (tap != null) {
          tap();
        }
      },
    );
  }
}

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();
}


class _IntroductionState extends State<Introduction> {

  // ページコントローラ
  final PageController controller = PageController(viewportFraction: 0.8);

  // ページインデックス
  final _currentPageNotifier = ValueNotifier<int>(0);

  // データ
  List<String> _imageList = [
    "image/home.png",
    "image/setting.png",
    "image/history.png",
  ];

  List<String> _textList = [
    "ホーム画面の説明",
    "設定画面の説明",
    "利用履歴の説明",
  ];

  @override
  void initState() {

    super.initState();

    // ページコントローラのページ遷移を監視しページ数を丸める
    controller.addListener(() {
      int next = controller.page.round();
      if (_currentPageNotifier.value != next) {

        setState(() {
          _currentPageNotifier.value = next;
        });
      }
    });
  }

  /*
   * アニメーションカード生成
   */
  AnimatedContainer _createCardAnimate(String imagePath, bool active) {

    // アクティブと非アクティブのアニメーション設定値
    final double top = active ? 0 : 400;
    final double side = active ? 0 : 40;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: 20, bottom: 14.0, right: 30, left: 30),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: Image.asset(imagePath).image,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Column(
        children: <Widget>[

          /*
           * ページ
           */
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: _imageList.length,
              itemBuilder: (context, int currentIndex) {

                // アクティブ値
                bool active = currentIndex == _currentPageNotifier.value;

                // カードの生成して返す
                return _createCardAnimate(
                  _imageList[currentIndex],
                  active,
                );
              },
            ),
          ),

          /*
           * ページインジケータ
           */
          Container(
            height: 5.0,
            child: CirclePageIndicator(
              itemCount: _imageList.length,
              currentPageNotifier: _currentPageNotifier,
            ),
          ),

          /*
           * 説明エリア
           */
          Container(
            height: 60.0,
            padding: EdgeInsets.all(7.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  _textList[_currentPageNotifier.value],
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//色をカラーコードで指定するためのクラス
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
