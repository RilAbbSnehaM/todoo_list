import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false);

  // Switch between dark and light themes
  void toggleTheme() async {
    final box = await Hive.openBox('themeBox');
    final currentTheme = box.get('isDarkMode', defaultValue: false);
    box.put('isDarkMode', !currentTheme);
    state = !currentTheme;
  }

  // Check if dark mode is enabled
  Future<bool> isDarkMode() async {
    final box = await Hive.openBox('themeBox');
    return box.get('isDarkMode', defaultValue: false);
  }
}
