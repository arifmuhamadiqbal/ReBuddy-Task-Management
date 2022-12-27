import 'package:calendar_app_task_management/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "tasks";

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
          _path,
        version: _version,
        onCreate: (db, version) {
            print("Creating a new one");
            return db.execute(
              "CREATE TABLE $_tableName ("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "title STRING,"
                  "note TEXT,"
                  "date STRING,"
                  "startTime STRING,"
                  "endTime STRING,"
                  "remind INTEGER,"
                  "repeat STRING,"
                  "color INTEGER,"
                  "isCompleted INTEGER)",
            );
        },
      );
    } catch (error) {
      print(error);
    }
  }

  // insert task
  static Future<int> insert(Task? task) async {
    print("Insert function called");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }

  // get all task
  static Future<List<Map<String, dynamic>>> query() async {
    print("Query function called");
    return await _db!.query(_tableName);
  }

  // delete task
  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  // update status task
static update(int id) async {
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
}
}