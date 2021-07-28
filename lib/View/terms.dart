import 'package:flutter/material.dart';
import 'package:stamp_app/Widget/AppBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsPage extends StatefulWidget {
  TermsPage({Key? key, required this.title}) : super(key: key);
  final String title;
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 25),
          Text(AppLocalizations.of(context)!.termsRead),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第1条
          Text(AppLocalizations.of(context)!.article1,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article1Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第2条
          Text(AppLocalizations.of(context)!.article2,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article2Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第3条
          Text(AppLocalizations.of(context)!.article3,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article3Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第4条
          Text(AppLocalizations.of(context)!.article4,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article4Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第5条
          Text(AppLocalizations.of(context)!.article5,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article5Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第6条
          Text(AppLocalizations.of(context)!.article6,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article6Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第7条
          Text(AppLocalizations.of(context)!.article7,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article7Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第8条
          Text(AppLocalizations.of(context)!.article8,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article8Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第9条
          Text(AppLocalizations.of(context)!.article9,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article9Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第10条
          Text(AppLocalizations.of(context)!.article10,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article10Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第11条
          Text(AppLocalizations.of(context)!.article11,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article11Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //第12条
          Text(AppLocalizations.of(context)!.article12,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          Text(AppLocalizations.of(context)!.article12Main),
          const Divider(
            height: 40,
            thickness: 1,
            color: Colors.black,
            indent: 16,
            endIndent: 16,
          ),
          //附則
          Text(AppLocalizations.of(context)!.withRules,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(AppLocalizations.of(context)!.enacted)
        ],
      ),
    );
  }
}
