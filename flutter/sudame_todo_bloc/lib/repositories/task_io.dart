import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:sudame_todo_bloc/models/task.dart';

class TaskRepository {
  static const String TABLE_NAME = 'tasks';

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      onCreate: (Database db, int version) {
        return db.execute(
          'CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, iscompleted BOOLEAN)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    final db = await database();

    await db.insert(
      TABLE_NAME,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(Task task) async {
    final db = await database();

    await db.update(
      TABLE_NAME,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(Task task) async {
    final db = await database();

    await db.delete(
      TABLE_NAME,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<List<Task>> get tasks async {
    final Database db = await database();

    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

    return List.generate(
      maps.length,
      (int index) {
        return Task.fromMap(maps[index]);
      },
    );
  }
}
