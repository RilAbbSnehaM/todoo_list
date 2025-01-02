import 'package:hive/hive.dart';

part 'task_sort.g.dart';  // This will generate the necessary code for Hive storage

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime date;  // Add the date field for sorting
  @HiveField(4)
  final int priority;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
  });
}
