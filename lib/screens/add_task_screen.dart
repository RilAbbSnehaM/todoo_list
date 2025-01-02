import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todoo_list/models/task.dart';
import 'package:todoo_list/provider/task_provider.dart';
class AddTaskScreen extends ConsumerStatefulWidget {
  final Task? task;

  AddTaskScreen({this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    }
  }

  void _saveTask() {
    final task = Task(
      id: widget.task?.id,
      title: _titleController.text,
      description: _descriptionController.text,
    );
    
    if (widget.task != null) {
      // Edit existing task
      ref.read(taskProvider.notifier).editTask(task);
    } else {
      // Add new task
      ref.read(taskProvider.notifier).addTask(task);
    }
    
    Navigator.pop(context);  // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text(widget.task == null ? 'Add Task' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
