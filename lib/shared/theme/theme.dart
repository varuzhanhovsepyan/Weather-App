import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(AppColors.primary),
        brightness: Brightness.light,
      ).copyWith(
        surface: Colors.white,
        onSurface: const Color(0xFF212121),
        onSurfaceVariant: const Color(0xFF757575),
      ),

      scaffoldBackgroundColor: const Color(0xFFFAFAFA),

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }


  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(AppColors.primary),
        brightness: Brightness.dark,
      ).copyWith(
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white,
        onSurfaceVariant: const Color(0xFFBDBDBD),
      ),

      scaffoldBackgroundColor: const Color(0xFF121212),

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}