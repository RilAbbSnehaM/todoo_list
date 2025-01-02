// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todoo_list/models/task.dart';
// import 'package:todoo_list/provider/task_provider.dart';

// import 'package:todoo_list/screens/add_task_screen.dart';

// class TaskList extends ConsumerWidget {
//   final List<Task> tasks;

//   TaskList({required this.tasks});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         final task = tasks[index];
//         return ListTile(
//           title: Text(task.title),
//           subtitle: Text(task.description),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Edit button
//               IconButton(
//                 icon: Icon(Icons.edit),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AddTaskScreen(
//                         task: task, // Passing the task for editing
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               // Delete button
//               IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: () {
//                   // Use ref.read(taskProvider.notifier) for deletion
//                   ref.read(taskProvider.notifier).deleteTask(task.id!);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
