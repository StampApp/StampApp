import 'package:flutter/material.dart';
import 'package:stamp_app/Widget/AppBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyPolicyPage extends StatefulWidget {
  PrivacyPolicyPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    //デバイスのサイズ取得
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(deviceHeight * 0.08),
          child: AppBarPage(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 50,
        ),
        children: <Widget>[
          SizedBox(height: deviceHeight * 0.04),
          Text(AppLocalizations.of(context)!.privacyPolicyRead),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第1条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle1,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle1Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第2条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle2,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle2Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第3条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle3,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle3Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第4条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle4,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle4Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第5条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle5,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle5Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第6条
          Text(AppLocalizations.of(context)!.privacyPolicyArticle6,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.privacyPolicyArticle6Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.withRules,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(AppLocalizations.of(context)!.privacyPolicyEnacted)
        ],
      ),
    );
  }
}
