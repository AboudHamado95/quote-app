import 'package:flutter_app3/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? db;
  static const int version = 1;
  static const String tableName = 'tasks';
  static Future<void> initDb() async {
    if (db != null) {
      print('not null db');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';
        print('in database path');
        db = await openDatabase(_path, version: version,
            onCreate: (Database db, int version) async {
          print('creating a new one');
          // When creating the db, create the table
          await db.execute('CREATE TABLE $tableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'title STRING,'
              'note TEXT,'
              'date STRING,'
              'startTime STRING,'
              'endTime STRING,'
              'remind INTEGER,'
              'repeat INTEGER,'
              'color INTEGER,'
              'isCompleted INTEGER)');
        });
        print('Database created');
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<List<Map<String, Object?>>> query() async {
    print('query function called');
    return await db!.query(tableName);
  }

  static Future<int> insert(Task? task) async {
    print('insert function called');
    return await db!.insert(tableName, task!.toJson());
  }

  static Future<int> delete(Task? task) async {
    print('delete function called');
    return await db!.delete(tableName, where: 'id = ?', whereArgs: [task!.id]);
  }

   static Future<int> deleteAll() async {
    print('delete all function called');
    return await db!.delete(tableName);
  }

  static Future<int> update(int id) async {
    print('update function called');
    return await db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }
}
