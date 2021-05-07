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
    return 'Memo{id: $id, tet: $text, priority: $priority}';
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

  // 取得
  static Future<List<Memo>> getMemos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('$_tableName');
    return List.generate(maps.length, (i) {
      return Memo(
        id: maps[i]['id'],
        text: maps[i]['text'],
        priority: maps[i]['priority'],
      );
    });
  }

  // 追加
  static Future<void> insertMemo(Memo memo) async {
    final Database db = await database;
    await db.insert(
      '$_tableName',
      memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 更新
  static Future<void> updateMemo(Memo memo) async {
    // Get a reference to the database.
    final db = await database;
    await db.update(
      '$_tableName',
      memo.toMap(),
      where: "id = ?",
      whereArgs: [memo.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  // 削除
  static Future<void> deleteMemo(int id) async {
    final db = await database;
    await db.delete(
      '$_tableName',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
