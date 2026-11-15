import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:harinios_app/app.dart';
import 'package:harinios_app/features/home/data/dashboard_preview_data.dart';
import 'package:harinios_app/features/home/presentation/home_screen.dart';
import 'package:harinios_app/core/theme/app_theme.dart';

void main() {
  testWidgets('bottom navigation opens each destination', (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const HariniOSApp());
    await tester.pumpAndSettle();

    expect(find.text('SAMPLE PREVIEW · NOT SAVED'), findsOneWidget);
    expect(find.text("TODAY'S PROGRESS"), findsOneWidget);
    expect(find.text("Today's tasks"), findsOneWidget);
    expect(find.byKey(const ValueKey('dashboard-date')), findsOneWidget);

    const destinations = {
      'Plan': 'Your daily and weekly plans will live here.',
      'Add': 'Create and capture items here.',
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

    await tester.pumpWidget(const HariniOSApp());
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Add a task'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Add a task'));
    await tester.pumpAndSettle();

    expect(find.text('Create and capture items here.'), findsOneWidget);
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
