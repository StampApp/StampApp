import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:stamp_app/Constants/setting.dart';
import 'package:stamp_app/Widget/HexColor.dart';

class InstructionsPage extends StatefulWidget {
  InstructionsPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _InstructionsPageState createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: HexColor(Setting.APP_COLOR),
      ),
      body: Introduction(),
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
  // 表示する画像
  List<String> _imageList = [
    "assets/images/instructions/home.jpg",
    "assets/images/instructions/setting.jpg",
    "assets/images/instructions/history.jpg",
  ];
  // 表示するテキスト
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
      int next = controller.page!.round();
      if (_currentPageNotifier.value != next) {
        setState(() {
          _currentPageNotifier.value = next;
        });
      }
    });
  }

  // アニメーションカード生成
  AnimatedContainer _createCardAnimate(String imagePath, bool active) {
    // アニメーション設定
    //デバイスのサイズを変数deviceHeightへ
    final double deviceHeight = MediaQuery.of(context).size.height;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      //空白をデバイスごとに変更
      margin: EdgeInsets.only(
          top: deviceHeight * 0.05,
          bottom: deviceHeight * 0.05,
          right: deviceHeight * 0.01,
          left: deviceHeight * 0.01),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: Image.asset(imagePath).image,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //デバイスのサイズを変数deviceHeightへ
    final double deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: <Widget>[
          // ページ
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: _imageList.length,
              itemBuilder: (context, int currentIndex) {
                // アクティブ値
                bool active = currentIndex == _currentPageNotifier.value;
                // _imageListに入れた画像の表示
                return _createCardAnimate(
                  _imageList[currentIndex],
                  active,
                );
              },
            ),
          ),
          // ページインジケータ
          Container(
            height: 5.0,
            child: CirclePageIndicator(
              itemCount: _imageList.length,
              currentPageNotifier: _currentPageNotifier,
            ),
          ),
          // 説明エリア
          Container(
            height: deviceHeight * 0.1,
            padding: EdgeInsets.all(7.0),
            child: Container(
              width: deviceHeight * 0.4, //double.infinity,
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
                    //横長のデバイス上でTextがつぶれないよう
                    fontSize: deviceHeight * 0.022,
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
