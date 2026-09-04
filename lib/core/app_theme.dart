// lib/core/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // الألوان المشتركة الأساسية
  static const Color warmOrange = Color(0xFFD35400); // البرتقالي الدافئ المطابق للصورة
  static const Color secondaryOrange = Color(0xFFF39C12);
  
  // -- ألوان الوضع الفاتح --
  static const Color lightBackground = Color(0xFFF5F5F7);
  static const Color charcoalGray = Color(0xFF36454F);

  // -- ألوان الوضع الغامق (مستخرجة بدقة من صورة home_dark.png) --
  static const Color darkBackground = Color(0xFF161C24); // اللون الأزرق-الرمادي الداكن للخلفية
  static const Color darkCardColor = Color(0xFF222B36); // اللون الأفتح للبطاقات والحاويات
  static const Color darkDividerColor = Color(0xFF2D3947); // حدود متناسقة وناعمة

  // ==========================================
  // 1. ثيم الوضع الفاتح (Light Mode)
  // ==========================================
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground,
    cardColor: Colors.white,
    dividerColor: Colors.grey.shade200,
    primaryColor: warmOrange,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: charcoalGray),
      bodyMedium: TextStyle(color: Colors.grey),
    ),
    iconTheme: const IconThemeData(color: charcoalGray),
  );

  // ==========================================
  // 2. ثيم الوضع الغامق (Dark Mode) - مطابق تماماً لصورة home_dark.png
  // ==========================================
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    cardColor: darkCardColor,
    dividerColor: darkDividerColor,
    primaryColor: warmOrange,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // نصوص بيضاء ساطعة للعناوين
      bodyMedium: TextStyle(color: Color(0xFF9BA4B5)), // نصوص رمادية مزرقة باهتة للتفاصيل
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}