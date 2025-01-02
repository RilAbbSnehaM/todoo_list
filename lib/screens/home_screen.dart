import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoo_list/models/task.dart';
import 'package:todoo_list/provider/task_provider.dart';
import 'package:todoo_list/provider/task_repo.dart';
import 'package:todoo_list/provider/theme_provider.dart';
import 'package:todoo_list/screens/add_task_screen.dart';

final taskRepositoryProvider = FutureProvider<TaskRepository>((ref) async {
  final taskRepo = TaskRepository();
  await taskRepo.init(); // Ensure repository is initialized
  return taskRepo;
});

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final Set<int> _completedTasks = {};
  String _sortBy = 'date';
  // Default sorting is by date

  // Track the long-pressed task
  int? _longPressedTaskId;
  @override
  void initState() {
    super.initState();
    // Fetch tasks when the screen is loaded
    ref.read(taskProvider.notifier).fetchTasks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider);
    final taskList = ref.watch(taskProvider);

    // Filter tasks based on search query
    final filteredTasks = taskList.where((task) {
      return task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          task.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _sortBy = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'date',
                child: Text('Sort by Date'),
              ),
              PopupMenuItem<String>(
                value: 'priority',
                child: Text('Sort by Priority (High to Low)'),
              ),
            ],
            icon: Icon(Icons.sort),
          ),
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () {
              // Toggle theme
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: filteredTasks.isEmpty
          ? Center(child: Text('No tasks found'))
          : ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                final isCompleted = _completedTasks.contains(task.id!);
                final isLongPressed = _longPressedTaskId == task.id;

                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      _longPressedTaskId = task.id;
                    });
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: isCompleted,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _completedTasks.add(task.id!);
                          } else {
                            _completedTasks.remove(task.id!);
                          }
                        });
                      },
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                        color: isLongPressed
                            ? Colors.red
                            : null, // Red color for long press
                      ),
                    ),
                    subtitle: Text(task.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Navigate to edit task
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddTaskScreen(task: task)));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            ref
                                .read(taskProvider.notifier)
                                .deleteTask(task.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
