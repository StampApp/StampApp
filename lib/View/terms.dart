import 'package:flutter/material.dart';
import 'package:stamp_app/Constants/setting.dart';
import '../Widget/HexColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsPage extends StatefulWidget {
  TermsPage({Key? key, required this.title}) : super(key: key);
  final String title;
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: HexColor(Setting.APP_COLOR),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 50,
        ),
        children: <Widget>[
          SizedBox(height: 25),
          Text(AppLocalizations.of(context)!.termsRead),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第1条
          Text(AppLocalizations.of(context)!.article1,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article1Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第2条
          Text(AppLocalizations.of(context)!.article2,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article2Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第3条
          Text(AppLocalizations.of(context)!.article3,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article3Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第4条
          Text(AppLocalizations.of(context)!.article4,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article4Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第5条
          Text(AppLocalizations.of(context)!.article5,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article5Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第6条
          Text(AppLocalizations.of(context)!.article6,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article6Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第7条
          Text(AppLocalizations.of(context)!.article7,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article7Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第8条
          Text(AppLocalizations.of(context)!.article8,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article8Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第9条
          Text(AppLocalizations.of(context)!.article9,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article9Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第10条
          Text(AppLocalizations.of(context)!.article10,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article10Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第11条
          Text(AppLocalizations.of(context)!.article11,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article11Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第12条
          Text(AppLocalizations.of(context)!.article12,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article12Main),
          Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //附則
          Text(AppLocalizations.of(context)!.withRules,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(AppLocalizations.of(context)!.enacted)
        ],
      ),
    );
  }
}
