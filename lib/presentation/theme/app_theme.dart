import 'package:flutter/material.dart';

class AppTheme {
  static const background = Color(0xFFFFFDF7);
  static const separator = Color(0xFFE6E4DA);
  static const titleText = Color(0xFF333333);
  static const bodyText = Color(0xFF666666);
  static const yellowHighlight = Color(0xFFFFEB59);
  static const paperTint = Color(0xFFFFFBEA);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      background: background,
      surface: paperTint,
      primary: titleText,
      secondary: bodyText,
      onBackground: titleText,
      onSurface: bodyText,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      foregroundColor: titleText,
      elevation: 0,
    ),
    cardTheme: const CardThemeData(
      color: paperTint,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: separator),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      background: const Color(0xFF1C1C1E),
      surface: const Color(0xFF2C2C2E),
      primary: Colors.white,
      secondary: Colors.grey[300]!,
      onBackground: Colors.white,
      onSurface: Colors.grey[300]!,
    ),
    scaffoldBackgroundColor: const Color(0xFF1C1C1E),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1C1C1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF2C2C2E),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[800]!),
      ),
    ),
  );
}
