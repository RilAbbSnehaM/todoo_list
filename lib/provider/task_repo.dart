import 'package:hive/hive.dart';
import 'package:todoo_list/models/task_sort.dart';


class TaskRepository {
  late Box<Task> taskBox;

  Future<void> init() async {
    taskBox = await Hive.openBox<Task>('tasks');
  }
  

  Future<List<Task>> getSortedTasks({String sortBy = 'date'}) async {
    final tasks = taskBox.values.toList();
    if (sortBy == 'date') {
      tasks.sort((a, b) => a.date.compareTo(b.date));
    } else if (sortBy == 'priority') {
      tasks.sort((a, b) => a.priority.compareTo(b.priority));
    }
    return tasks;
  }

  // Save a task: add new task or update existing task
  Future<void> saveTask(Task task) async {
    if (task.id == null) {
      // If the task doesn't have an ID, add it as a new task
      await taskBox.add(task);
    } else {
      // If the task has an ID, update the existing task
      await taskBox.put(task.id!, task);
    }
  }

  Future<void> addTask(Task task) async {
    await taskBox.add(task);
  }

  Future<void> updateTask(int key, Task task) async {
    await taskBox.put(key, task);
  }

  Future<void> deleteTask(int key) async {
    await taskBox.delete(key);
  }

  Task? getTask(int key) {
    return taskBox.get(key);
  }

  Future<void> close() async {
    await taskBox.close();
  }
}
