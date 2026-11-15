import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

abstract interface class TaskRepository {
  Stream<List<TaskItem>> watchTasks();
  Future<int> addTask(String title);
  Future<bool> updateTaskTitle(int id, String title);
  Future<bool> setTaskCompleted(int id, bool isCompleted);
  Future<bool> deleteTask(int id);
}

class DriftTaskRepository implements TaskRepository {
  const DriftTaskRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<TaskItem>> watchTasks() {
    return (_database.select(_database.tasks)..orderBy([
          (task) => OrderingTerm(expression: task.isCompleted),
          (task) => OrderingTerm.desc(task.createdAt),
        ]))
        .watch();
  }

  @override
  Future<int> addTask(String title) {
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      throw ArgumentError.value(title, 'title', 'Task title cannot be empty.');
    }

    return _database
        .into(_database.tasks)
        .insert(TasksCompanion.insert(title: trimmedTitle));
  }

  @override
  Future<bool> updateTaskTitle(int id, String title) async {
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      throw ArgumentError.value(title, 'title', 'Task title cannot be empty.');
    }

    final updatedCount =
        await (_database.update(_database.tasks)
              ..where((task) => task.id.equals(id)))
            .write(TasksCompanion(title: Value(trimmedTitle)));
    return updatedCount > 0;
  }

  @override
  Future<bool> setTaskCompleted(int id, bool isCompleted) async {
    final updatedCount =
        await (_database.update(_database.tasks)
              ..where((task) => task.id.equals(id)))
            .write(TasksCompanion(isCompleted: Value(isCompleted)));
    return updatedCount > 0;
  }

  @override
  Future<bool> deleteTask(int id) async {
    final deletedCount = await (_database.delete(
      _database.tasks,
    )..where((task) => task.id.equals(id))).go();
    return deletedCount > 0;
  }
}
