import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:harinios_app/app.dart';
import 'package:harinios_app/core/database/app_database.dart';
import 'package:harinios_app/features/home/data/dashboard_preview_data.dart';
import 'package:harinios_app/features/home/presentation/home_screen.dart';
import 'package:harinios_app/features/tasks/domain/task_repository.dart';
import 'package:harinios_app/core/theme/app_theme.dart';

class _MemoryTaskRepository implements TaskRepository {
  final List<TaskItem> _tasks = [];
  int _nextId = 1;

  @override
  Stream<List<TaskItem>> watchTasks() => Stream.value(List.of(_tasks));

  @override
  Future<int> addTask(String title) async {
    final id = _nextId++;
    _tasks.add(
      TaskItem(
        id: id,
        title: title.trim(),
        notes: null,
        createdAt: DateTime.now(),
        isCompleted: false,
      ),
    );
    return id;
  }

  @override
  Future<bool> updateTaskTitle(int id, String title) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index < 0) return false;
    _tasks[index] = _tasks[index].copyWith(title: title.trim());
    return true;
  }

  @override
  Future<bool> setTaskCompleted(int id, bool isCompleted) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index < 0) return false;
    _tasks[index] = _tasks[index].copyWith(isCompleted: isCompleted);
    return true;
  }

  @override
  Future<bool> deleteTask(int id) async {
    final previousLength = _tasks.length;
    _tasks.removeWhere((task) => task.id == id);
    return _tasks.length != previousLength;
  }
}

Future<void> pumpApp(WidgetTester tester) async {
  await tester.pumpWidget(HariniOSApp(taskRepository: _MemoryTaskRepository()));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('bottom navigation opens each destination', (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpApp(tester);

    expect(find.text('SAMPLE PREVIEW · NOT SAVED'), findsOneWidget);
    expect(find.text("TODAY'S PROGRESS"), findsOneWidget);
    expect(find.text("Today's tasks"), findsOneWidget);
    expect(find.byKey(const ValueKey('dashboard-date')), findsOneWidget);

    const destinations = {
      'Plan': 'Nothing planned yet.',
      'Add': 'Capture one thing you want to get done.',
      'Insights': 'Your progress and patterns will appear here.',
      'Settings': 'Personalize your HariniOS experience here.',
      'Home': 'SAMPLE PREVIEW · NOT SAVED',
    };

    for (final entry in destinations.entries) {
      final destination = find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text(entry.key),
      );
      await tester.tap(destination);
      await tester.pumpAndSettle();

      expect(find.text(entry.value), findsOneWidget);
    }

    for (final section in ['Habit check-in', 'Study progress', 'Daily goals']) {
      await tester.scrollUntilVisible(
        find.text(section),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(section), findsOneWidget);
    }
  });

  testWidgets('dashboard quick action opens Add destination', (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpApp(tester);
    await tester.scrollUntilVisible(
      find.text('Add a task'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Add a task'));
    await tester.pumpAndSettle();

    expect(
      find.text('Capture one thing you want to get done.'),
      findsOneWidget,
    );
  });

  testWidgets('a task can be created and shown in the plan', (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpApp(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Add'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('task-title-input')),
      'Persist my first task',
    );
    await tester.tap(find.byKey(const ValueKey('save-task-button')));
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Plan'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Persist my first task'), findsOneWidget);
  });

  testWidgets('dashboard shows empty states when preview data is empty', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen(data: DashboardPreviewData.empty)),
    );
    await tester.pumpAndSettle();
    const emptyStates = [
      'Nothing planned yet. Enjoy the breathing room.',
      'Your habit check-in will show up here.',
      'Add a study target to see your progress here.',
      'Choose one small thing to make today count.',
    ];
    for (final message in emptyStates) {
      await tester.scrollUntilVisible(
        find.text(message),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(message), findsOneWidget);
    }
  });

  test('material theme definitions are enabled for light and dark modes', () {
    expect(AppTheme.lightTheme.useMaterial3, isTrue);
    expect(AppTheme.darkTheme.useMaterial3, isTrue);
    expect(AppTheme.lightTheme.colorScheme.primary, isNotNull);
    expect(AppTheme.darkTheme.colorScheme.primary, isNotNull);
  });
}
