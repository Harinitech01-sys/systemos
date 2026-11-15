import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harinios_app/core/database/app_database.dart';
import 'package:harinios_app/features/tasks/domain/task_repository.dart';

void main() {
  late AppDatabase database;
  late TaskRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftTaskRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates, reads, updates, completes, and deletes tasks', () async {
    final id = await repository.addTask('  Review priorities  ');
    var tasks = await repository.watchTasks().first;

    expect(tasks, hasLength(1));
    expect(tasks.single.id, id);
    expect(tasks.single.title, 'Review priorities');
    expect(tasks.single.isCompleted, isFalse);

    expect(await repository.updateTaskTitle(id, 'Plan the week'), isTrue);
    expect(await repository.setTaskCompleted(id, true), isTrue);
    tasks = await repository.watchTasks().first;
    expect(tasks.single.title, 'Plan the week');
    expect(tasks.single.isCompleted, isTrue);

    expect(await repository.deleteTask(id), isTrue);
    expect(await repository.watchTasks().first, isEmpty);
    expect(await repository.deleteTask(id), isFalse);
  });

  test('rejects empty task titles', () {
    expect(() => repository.addTask('  '), throwsArgumentError);
  });
}
