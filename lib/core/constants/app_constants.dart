import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2C6B5D);
  static const Color primaryContainer = Color(0xFFDFF5EC);
  static const Color primaryLight = Color(0xFF5AA58C);
  static const Color primaryDark = Color(0xFF1D4F42);
  static const Color secondary = Color(0xFF92B7A5);
  static const Color secondaryContainer = Color(0xFFE7F3EE);
  static const Color tertiary = Color(0xFFC8E1D7);
  static const Color accent = Color(0xFF94C9B7);
  static const Color background = Color(0xFFF5F7F4);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFF1F6F3);
  static const Color surfaceVariant = Color(0xFFE8F1ED);
  static const Color outline = Color(0xFFD7E3DD);
  static const Color outlineVariant = Color(0xFFBFD7CE);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF163A32);
  static const Color onSurface = Color(0xFF172521);
  static const Color onSurfaceVariant = Color(0xFF5B6E68);
  static const Color success = Color(0xFF2F8F5B);
  static const Color info = Color(0xFF4C7BCF);
  static const Color warning = Color(0xFFE3A93A);
  static const Color error = Color(0xFFCE4B4B);
  static const Color shadow = Color(0x1F233A2F);
}

class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
}

class AppBorderRadius {
  AppBorderRadius._();

  static const BorderRadius small = BorderRadius.all(Radius.circular(12));
  static const BorderRadius medium = BorderRadius.all(Radius.circular(18));
  static const BorderRadius large = BorderRadius.all(Radius.circular(28));
}
