import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  final String databaseName;
  final String databaseSchema;
  final String databaseInset;
  final String? databaseUpdate;

  DB({
    required this.databaseName,
    required this.databaseSchema,
    required this.databaseInset,
    this.databaseUpdate,
  });

  factory DB.fromJson(Map<String, dynamic> json) {
    return DB(
      databaseName: json['name'],
      databaseSchema: json['schema'],
      databaseInset: json['insert'],
      databaseUpdate: json['update'],
    );
  }

  Future<String> getPath() async {
    if (Platform.isIOS) {
      final library = await getLibraryDirectory();
      return library.path;
    } else {
      return await getDatabasesPath();
    }
  }

  Future<Database> open() async {
    try {
      var databasesPath = await getPath();
      final String path = '$databasesPath/$databaseName.db';
      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE $databaseName $databaseSchema');
        },
      );
      return database;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> insert(List<String> values) async {
    try {
      final database = await open();
      final row = await database.rawInsert(
          "INSERT INTO $databaseName $databaseInset", values);
      await database.close();
      return row;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> update(List<String> values) async {
    try {
      final database = await open();
      final row = await database.rawInsert(
          "UPDATE $databaseName SET $databaseUpdate", values);
      await database.close();
      return row;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertList(List<String> values, Database database) async {
    try {
      await database.rawInsert(
          "INSERT INTO $databaseName $databaseInset", values);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateList(List<String> values, Database database) async {
    try {
      await database.rawUpdate(
          "UPDATE $databaseName SET $databaseUpdate", values);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    try {
      final database = await open();
      final result = await database.rawQuery("SELECT * FROM $databaseName");
      await database.close();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getById(String id) async {
    try {
      final database = await open();
      final result = await database.rawQuery(
          "SELECT * FROM $databaseName WHERE id = ?", [id]).then((value) {
        if (value.isEmpty) return null;
        return value.first;
      });
      await database.close();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAll() async {
    try {
      final database = await open();
      await database.rawDelete("DELETE FROM $databaseName");
      await database.close();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteById(String id) async {
    try {
      final database = await open();
      await database.rawDelete('DELETE FROM $databaseName WHERE id = ?', [id]);
      await database.close();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> close() async {
    final database = await open();
    await database.close();
  }
}
