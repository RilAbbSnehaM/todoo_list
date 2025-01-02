import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'MVVM To-Do App';
  static const String version = '1.0.0';

  // Database
  static const String databaseName = 'tasks.db';
  static const String taskTable = 'tasks';

  // Texts
  static const String noTasksMessage = 'No tasks available';
  static const String addTaskTitle = 'Add a new task';
  static const String taskHint = 'Enter task title';

  // Colors
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color accentColor = Color(0xFF03DAC5);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF212121);
  static const Color errorColor = Color(0xFFB00020);

  // Dimensions
  static const double padding = 16.0;
  static const double cardElevation = 4.0;
  static const double borderRadius = 8.0;

  // Icons
  static const IconData addIcon = Icons.add;
  static const IconData editIcon = Icons.edit;
  static const IconData deleteIcon = Icons.delete;

  // Responsive Breakpoints
  static const double tabletBreakpoint = 600.0;
}
