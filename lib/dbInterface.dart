import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:stamp_app/Util/Enums/enumStampCount.dart';

/// LocalのSQLiteと通信を行うクラス
///
/// sqfliteパッケージ使用して条件などを記述する
/// 条件文には[db.query]と[db.rawQuery]が存在する
/// 基本は[db.query]、条件が複雑でありSQL文を使用したい場合、[db.rawQuery]を使用するのが〇
///
/// 処理をする際、[model]型 [Map]型で相互変換する必要あり
/// 例: select時 [Map]型 -> [model]型
///
/// テーブルとmodelでカラムの型に違いがある場合、変換する必要あり
/// 例: [stamp_date] テーブル -> [text],  model -> [DateTime]
///
/// 以下、参考文献
/// sqflite通信サンプル: https://flutter.ctrnost.com/logic/sqlite/
/// SQLiteで利用できる型 : https://www.dbonline.jp/sqlite/type/index1.html

class DbInterface {
  /*
  @param _tableName テーブル名
  @param database   DB
  @param id         レコードID
  */
  // idを指定して取得
  static Future<List> select(String _tableName, var database, String id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('$_tableName',
        where: 'id = ?', orderBy: 'id asc', whereArgs: [id]);
    return maps;
  }

  /*
  @param _tableName テーブル名
  @param database   DB
  @param nowDate 現在の日付
  @param pastMonths 何ヶ月かを指定
  */
  // ($_pastMonths)ヶ月前に取得したデータを日付時刻を降順で全件取得
  static Future<List> selectDateDesc(
      String _tableName, var database, DateTime nowDate, int pastMonths) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * " +
        "FROM $_tableName " +
        "WHERE datetime('$nowDate', '-$pastMonths months') " +
        "< stamp_date " +
        "order by stamp_date desc, stamp_time desc");
    return maps;
  }

  // 利用履歴を取得する
  static Future<List> selectDateDescLogs(
      String _tableName, var database, DateTime nowDate, int pastMonths) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * " +
        "FROM $_tableName " +
        "WHERE datetime('$nowDate', '-$pastMonths months') " +
        "< stamp_date " +
        "order by stamp_date desc, stamp_time desc");
    return maps;
  }

  // deleteflgがfalseのスタンプ数を取得する
  static Future<int> selectStampCount(String _tableName, var database) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT count(*) as count " + "FROM $_tableName " + "WHERE useflg = 0");
    int count = maps[0]['count'];
    return count;
  }

  // deleteFlgがfalseのスタンプを取得する
  static Future<List> selectDeleteFlg(String _tableName, var database) async {
    final int stampCheckString = StampCount.count.stampCount!;
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('$_tableName',
        where: 'useflg = ?',
        limit: stampCheckString,
        orderBy: 'stamp_date asc, stamp_time asc',
        whereArgs: [0]);
    return maps;
  }

  // 全件取得
  static Future<List> allSelect(String _tableName, var database) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps;
  }

  /*
  @param _tableName テーブル名
  @param database   DB
  @param values     テーブルの型を持った更新内容
  */
  // 追加
  static Future<void> insert(
      String _tableName, var database, var values) async {
    final Database db = await database;
    await db.insert(
      '$_tableName',
      values.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /*
  @param _tableName テーブル名
  @param database   DB
  @param values     テーブルの型を持った更新内容
  */
  // 更新
  static Future<void> update(
      String _tableName, var database, var values) async {
    // Get a reference to the database.
    final db = await database;
    await db.update(
      '$_tableName',
      values.toMap(),
      where: "id = ?",
      whereArgs: [values.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  /*
  @param _tableName テーブル名
  @param database   DB
  @param id         レコードID
  */
  // 削除
  static Future<void> delete(String _tableName, var database, String id) async {
    final db = await database;
    await db.delete(
      '$_tableName',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // 全件削除
  static Future<void> allDelete(String _tableName, var database) async {
    final db = await database;
    await db.delete(
      '$_tableName',
    );
  }
}
