import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoo_list/models/task.dart';

class TaskDB {
  static Database? _database;  // Declare database as nullable

  // Make sure to initialize the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If the database is not initialized, initialize it
    _database = await _initDB();
    return _database!;
  }

  // Create database and tables
  Future<Database> _initDB() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      join(path, 'task_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
  }

  // Example of inserting a task
  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  // Example of fetching all tasks
  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
      );
    });
  }

  // Example of updating a task
  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Example of deleting a task
  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
}
