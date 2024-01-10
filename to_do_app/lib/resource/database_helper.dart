import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/features/diaplay_list/task_model.dart'; // For path manipulation

class DatabaseHelper {
  static const _databaseName = 'todo_database.db';
  static const _tableName = 'tasks';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      path.join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'title TEXT, '
          'description TEXT, '
          'dueDate TEXT, '
          'priority TEXT, '
          'category TEXT, '
          'status TEXT'
          ')',
        );
      },
      version: 1,
    );

    return _database!;
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert(
      _tableName,
      {
        'id': task.id,
        'title': task.title,
        'description': task.description,
        'dueDate': task.dueDate.toString(),
        'priority': task.priority.toString(), // Convert enum to string
        'category': task.category,
        'status': task.status.toString(), // Convert enum to string
      },
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Specify the conflict algorithm
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      print(
        DateTime.parse(maps[i]['dueDate']),
      );
      print(
      maps[i]['dueDate'],
      );
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        dueDate: DateTime.parse(maps[i]['dueDate']),
        priority: maps[i]['priority'],
        category: maps[i]['category'],
        status: maps[i]['status'],
      );
    });
  }

  Future<void> deleteAllTasks() async {
    final db = await database;
    await db.delete(_tableName);
  }

  Future<void> deleteTaskById(int taskId) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  // ... Add other CRUD methods as needed (getTasks, updateTask, deleteTask)
}
