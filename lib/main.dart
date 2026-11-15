import 'package:flutter/material.dart';

import 'app.dart';
import 'core/error/app_error_handler.dart';

void main() {
  AppErrorHandler.initialize();
  runApp(const HariniOSApp());
}
