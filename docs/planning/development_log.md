# Development Log

## Day 1 — Project foundation

### Work completed
- Inspected the default Flutter starter project and confirmed it was the generated template.
- Replaced the demo app with a clean HariniOS app entry point.
- Added a Material 3 light/dark theme foundation and shared styling constants.
- Added a startup screen to verify the app launches cleanly.
- Implemented a basic application-wide error handler to catch uncaught Flutter and platform errors.
- Updated the project documentation and architecture notes.

### Files created
- `lib/app.dart`
- `lib/core/constants/app_constants.dart`
- `lib/core/error/app_error_handler.dart`
- `lib/core/theme/app_theme.dart`
- `docs/planning/project_vision.md`
- `docs/architecture/system_architecture.md`
- `docs/planning/development_log.md`

### Files modified
- `lib/main.dart`
- `README.md`
- `test/widget_test.dart`

### Dependencies added
- No new packages were added for Day 1.

### Tests performed
- `flutter test`
- `flutter analyze`

### Known issues
- No functional database or navigation layers have been added yet; those are scheduled for Day 2 onward.
- Full desktop launch is currently blocked by a missing Visual Studio toolchain in this environment, even though the app passes analyzer and widget tests.

## Day 2 — UI architecture and navigation

### Work completed
- Added GoRouter and a stateful indexed application shell.
- Added bottom navigation for Home, Plan, Add, Insights, and Settings.
- Created a separate presentation screen for each destination and shared placeholder UI.
- Replaced the Day 1 startup demo with the Home destination, ready for the Day 3 dashboard.
- Added a widget test that navigates through all five destinations.

### Files created
- `lib/core/navigation/app_router.dart`
- `lib/core/navigation/app_shell.dart`
- `lib/shared/widgets/destination_placeholder.dart`
- `lib/features/home/presentation/home_screen.dart`
- `lib/features/plan/presentation/plan_screen.dart`
- `lib/features/add/presentation/add_screen.dart`
- `lib/features/insights/presentation/insights_screen.dart`
- `lib/features/settings/presentation/settings_screen.dart`

### Files modified
- `lib/app.dart`
- `pubspec.yaml`
- `pubspec.lock`
- `test/widget_test.dart`
- `README.md`
- `docs/planning/project_vision.md`
- `docs/architecture/system_architecture.md`
- `docs/planning/development_log.md`

### Dependencies added
- `go_router` (resolved to the version compatible with the project's SDK constraints).

### Tests performed
- `dart format lib test` — passed.
- `flutter analyze` — passed with no issues.
- `flutter test` — passed, 2 tests; the navigation test covers all five destinations at a 360 × 800 Android-sized viewport.

### Known issues
- The five destinations are navigation placeholders; their feature functionality is planned for later days.

### Next day objective
- Build the dashboard UI with a time-aware greeting, date, progress, and empty states.

## Day 3 — Dashboard UI

### Work completed
- Replaced the Home placeholder with a responsive, scrollable dashboard.
- Added a time-aware greeting, current date, daily task progress, today's tasks, habit check-in, study progress, daily goals, and quick actions.
- Added separately typed, in-memory preview data with realistic sample content and an empty data set.
- Clearly labeled the dashboard content as a sample preview that is not saved.
- Connected quick actions to the existing Add, Plan, and Settings destinations.
- Added widget tests for dashboard sections, empty states, and navigation from a quick action.

### Files created
- `lib/features/home/data/dashboard_preview_data.dart`
- `lib/features/home/presentation/widgets/dashboard_sections.dart`

### Files modified
- `lib/features/home/presentation/home_screen.dart`
- `test/widget_test.dart`
- `README.md`
- `docs/planning/project_vision.md`
- `docs/architecture/system_architecture.md`
- `docs/planning/development_log.md`

### Dependencies added
- No new packages were added for Day 3.

### Tests performed
- `dart format lib test` — passed.
- `flutter analyze` — passed with no issues.
- `flutter test` — passed, 4 tests including navigation, dashboard preview and empty states, and a quick-action route.

### Known issues
- Dashboard content is sample preview data only and does not persist or update from task/habit actions.
- Plan, Add, Insights, and Settings are still placeholder destinations.

### Next day objective
- Add Drift and SQLite foundation, initial tables, repositories, and task CRUD persistence.

## Day 4 — local task persistence

### Work completed
- Added a Drift/SQLite database with a versioned tasks table.
- Added a task repository for creating, watching, renaming, completing, and deleting tasks.
- Replaced the Add and Plan placeholders with task entry and persisted task management screens.
- Added in-memory database tests for task CRUD and a widget test for creating and viewing a saved task.

### Files modified
- `lib/core/database/app_database.dart`
- `lib/features/tasks/domain/task_repository.dart`
- `lib/features/add/presentation/add_screen.dart`
- `lib/features/plan/presentation/plan_screen.dart`
- `lib/core/navigation/app_router.dart`
- `lib/app.dart`
- `test/task_repository_test.dart`
- `test/widget_test.dart`
- `pubspec.yaml`
- `pubspec.lock`
- `README.md`
- `docs/architecture/system_architecture.md`

### Tests performed
- `dart format lib test`
- `flutter analyze`
- `flutter test`

### Notes
- The sage palette was a separate visual polish pass and is not counted as Day 4 functionality.
