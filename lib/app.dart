import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/database/app_database.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/tasks/domain/task_repository.dart';

class HariniOSApp extends StatefulWidget {
  const HariniOSApp({this.database, this.taskRepository, super.key});

  final AppDatabase? database;
  final TaskRepository? taskRepository;

  @override
  State<HariniOSApp> createState() => _HariniOSAppState();
}

class _HariniOSAppState extends State<HariniOSApp> {
  AppDatabase? _database;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final taskRepository = widget.taskRepository;
    if (taskRepository != null) {
      _router = createAppRouter(taskRepository);
    } else {
      _database = widget.database ?? AppDatabase();
      _router = createAppRouter(DriftTaskRepository(_database!));
    }
  }

  @override
  void dispose() {
    _router.dispose();
    if (widget.database == null && widget.taskRepository == null) {
      unawaited(_database!.close());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HariniOS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}
