import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2D6A4F);
  static const Color primaryContainer = Color(0xFFDDF7EA);
  static const Color accent = Color(0xFF8DB9A0);
  static const Color surface = Color(0xFFF5F7F6);
  static const Color surfaceVariant = Color(0xFFE5EFEA);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1A1C1B);
  static const Color onSurfaceVariant = Color(0xFF5E6862);
  static const Color success = Color(0xFF2E8B57);
  static const Color warning = Color(0xFFE0A93A);
  static const Color error = Color(0xFFB42318);
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
