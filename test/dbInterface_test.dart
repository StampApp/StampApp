import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:stamp_app/dbInterface.dart';

class Test {
  final String id;
  final String title;
  final int flg;

  Test({
    this.id,
    this.title,
    this.flg,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'flg': flg,
    };
  }

  @override
  String toString() {
    return 'Test{id: $id, title: $title, flg: $flg}';
  }
}

void main() {
  group('dbInterface Test: ', () {
    test("DBInterfaceのSelectを利用して取ってきたが元データと同一か比較 -> true", () async {
      var databaseFactory = databaseFactoryFfi;
      var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      await db.execute('''
        CREATE TABLE Test (
          id TEXT PRIMARY KEY,
          title TEXT,
          flg INTEGER
        )
      ''');

      Test test = Test(id: "1111", title: "test", flg: 0);
      await db.insert('Test', test.toMap());
      var maps = await DbInterface.select("Test", db, "1111");
      var list = List.generate(maps.length, (i) {
        return Test(
          id: maps[i]['id'],
          title: maps[i]['title'],
          flg: maps[i]['flg'],
        );
      });
      await db.close();

      expect(mapEquals(list[0].toMap(), test.toMap()), true);
    });

    test("DBInterfaceのallSelectを利用して取ってきたデータが元データと同一か比較 -> true", () async {
      var databaseFactory = databaseFactoryFfi;
      var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      await db.execute('''
        CREATE TABLE Test (
          id TEXT PRIMARY KEY,
          title TEXT,
          flg INTEGER
        )
      ''');
      Test test1 = Test(id: "1111", title: "test", flg: 0);
      Test test2 = Test(id: "2222", title: "test", flg: 0);

      await db.insert('Test', test1.toMap());
      await db.insert('Test', test2.toMap());

      var maps = await DbInterface.allSelect("Test", db);
      var list = List.generate(maps.length, (i) {
        return Test(
          id: maps[i]['id'],
          title: maps[i]['title'],
          flg: maps[i]['flg'],
        );
      });
      await db.close();

      expect(
          mapEquals(list[0].toMap(), test1.toMap()) &&
              mapEquals(list[1].toMap(), test2.toMap()),
          true);
    });

    test("DBInterfaceのupdateを利用して更新したデータが更新の元となったデータと同一か比較 -> true", () async {
      var databaseFactory = databaseFactoryFfi;
      var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      await db.execute('''
        CREATE TABLE Test (
          id TEXT PRIMARY KEY,
          title TEXT,
          flg INTEGER
        )
      ''');

      Test test = Test(id: "1111", title: "test", flg: 0);
      Test testAfter = Test(id: "1111", title: "After", flg: 1);
      await db.insert('Test', test.toMap());

      await DbInterface.update("Test", db, testAfter);

      var maps = await db.query('Test');
      var list = List.generate(maps.length, (i) {
        return Test(
          id: maps[i]['id'],
          title: maps[i]['title'],
          flg: maps[i]['flg'],
        );
      });
      await db.close();
      expect(mapEquals(list[0].toMap(), testAfter.toMap()), true);
    });

    test("1件のみ入っているデータをDbInterfaceのdelete利用して削除し、データの件数が0になったか比較 -> true",
        () async {
      var databaseFactory = databaseFactoryFfi;
      var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      await db.execute('''
        CREATE TABLE Test (
          id TEXT PRIMARY KEY,
          title TEXT,
          flg INTEGER
        )
      ''');

      Test test = Test(id: "1111", title: "test", flg: 0);
      await db.insert('Test', test.toMap());

      await DbInterface.delete("Test", db, "1111");

      var maps = await db.query('Test');
      var list = List.generate(maps.length, (i) {
        return Test(
          id: maps[i]['id'],
          title: maps[i]['title'],
          flg: maps[i]['flg'],
        );
      });
      await db.close();
      expect(list.length == 0, true);
    });
    test("複数件のデータをDbInterfaceのallDelete利用して削除し、データの件数が0になったか -> true",
        () async {
      var databaseFactory = databaseFactoryFfi;
      var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      await db.execute('''
        CREATE TABLE Test (
          id TEXT PRIMARY KEY,
          title TEXT,
          flg INTEGER
        )
      ''');

      Test test1 = Test(id: "1111", title: "test", flg: 0);
      Test test2 = Test(id: "2222", title: "test", flg: 0);
      await db.insert('Test', test1.toMap());
      await db.insert('Test', test2.toMap());

      await DbInterface.allDelete("Test", db);

      var maps = await db.query('Test');
      var list = List.generate(maps.length, (i) {
        return Test(
          id: maps[i]['id'],
          title: maps[i]['title'],
          flg: maps[i]['flg'],
        );
      });
      await db.close();
      expect(list.length == 0, true);
    });
  });
}
