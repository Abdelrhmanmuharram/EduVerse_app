import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color secondText = Color(0xFF64748B);
  static const Color black = Color(0xFF0D131C);
  static const Color hintText = Color(0xFF94A3B8);
  static const Color red = Color(0xFFF43F5E);
  static const Color green = Color(0xFF16A34A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color primaryDark = Color(0xFF3C83F6);
  static const Color backgroundDark = Color(0xFF0F172A);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarThemeData(
      backgroundColor: backgroundLight,
      centerTitle: true,
      titleTextStyle: TextStyle(color: black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLight,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
        minimumSize: Size(double.infinity, 60),
        elevation: 0,
      ),
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: .w400,
        color: primaryLight,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: .bold,
        color: secondText,
      ),
      titleLarge: TextStyle(fontSize: 18, fontWeight: .bold, color: white),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: .bold, color: black),
      headlineMedium: TextStyle(fontSize: 30, fontWeight: .bold, color: black),
    ),
  );
  static ThemeData darkTheme = ThemeData();
}
