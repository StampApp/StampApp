import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Memo {
  static final _tableName = 'memo';

  // モデル定義
  final int id;
  final String text;
  final int priority;

  Memo({this.id, this.text, this.priority});

  // MemoからMap型に変換
  //カラム名に対応する必要あり
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'priority': priority,
    };
  }

  @override
  String toString() {
    return 'Memo{id: $id, text: $text, priority: $priority}';
  }

  // テーブル作成
  // join関数でデータベースのパスを設定
  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(), 'memo_database.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE $_tableName ("
            "id INTEGER PRIMARY KEY,"
            "text TEXT,"
            "priority INTEGER"
            ")");
      },
      version: 1,
    );
    return _database;
  }
}
