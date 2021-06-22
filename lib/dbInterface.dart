import 'dart:async';
import 'package:sqflite/sqflite.dart';

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
  */
  //全件取得
  static Future<List> allSelect(String _tableName, var database) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    // List.generate(maps.length, (i) => {print(maps[i])});
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
