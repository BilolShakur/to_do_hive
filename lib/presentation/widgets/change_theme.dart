import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tod_do_or_not_to_do/presentation/providers/theme_provider.dart';

void toggleTheme(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  final currentTheme = themeProvider.themeMode;
  ThemeMode newTheme;

  switch (currentTheme) {
    case ThemeMode.light:
      newTheme = ThemeMode.dark;
      break;
    case ThemeMode.dark:
      newTheme = ThemeMode.system;
      break;
    default:
      newTheme = ThemeMode.light;
  }

  themeProvider.setThemeMode(newTheme);
}
