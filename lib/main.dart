import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:device_preview/device_preview.dart'; // Import Device Preview
import 'package:todoo_list/models/task_sort.dart';

import 'package:todoo_list/provider/theme_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
 Hive.registerAdapter(TaskAdapter()); 
 
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: !kReleaseMode, // Enable Device Preview in debug mode only
        builder: (context) => MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true, // Enables DevicePreview to simulate device media
      locale: DevicePreview.locale(context), // Sets locale from DevicePreview
      builder: DevicePreview.appBuilder, // Wraps app with DevicePreview
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(),
    );
  }
}
