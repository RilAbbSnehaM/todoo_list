import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoo_list/database/task_db.dart';
import 'package:todoo_list/models/task.dart';


final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  final TaskDB _taskDB = TaskDB();
  

  Future<void> fetchTasks() async {
    final tasks = await _taskDB.getTasks();
    state = tasks;
  }

  Future<void> addTask(Task task) async {
    await _taskDB.insertTask(task);
    await fetchTasks();  // Refresh the task list
  }

  Future<void> editTask(Task task) async {
    await _taskDB.updateTask(task);
    await fetchTasks();  // Refresh the task list
  }

  Future<void> deleteTask(int id) async {
    await _taskDB.deleteTask(id);
    await fetchTasks();  // Refresh the task list
  }
  
}
