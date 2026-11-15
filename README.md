# HariniOS

HariniOS is a personal life-management system built with Flutter and Material 3. This repository is being developed in focused daily milestones.

## Current project status
- Day 1 foundation, Day 2 navigation shell, and Day 3 dashboard UI are in place.
- Material 3 light and dark themes are configured.
- Shared constants and startup error handling are in place.
- GoRouter provides five destinations: Home, Plan, Add, Insights, and Settings.
- Home shows a responsive dashboard with greeting, date, progress, tasks, habits, study, goals, and quick actions.
- Dashboard content is clearly labeled sample preview data and is not persisted.
- Plan, Add, Insights, and Settings remain placeholder screens.

## Project structure
- `lib/app.dart` – application root and startup shell
- `lib/core/navigation/` – GoRouter setup and bottom-navigation shell
- `lib/core/` – reusable app-wide logic, constants, and theme definitions
- `lib/features/` – feature-first destination screens and future modules
- `lib/shared/` – reusable UI components
- `docs/` – planning, documentation, and development history

## Run locally
```bash
flutter pub get
flutter run
```

## Verification
- `dart format lib test`
- `flutter analyze`
- `flutter test`

## Environment note
The local desktop launch check is currently blocked by a missing Visual Studio toolchain on this machine. The app code itself is passing the repository’s analyzer and widget tests.

See the planning and architecture notes in the `docs/` folder for the current direction and daily progress. Day 4 will establish local database persistence.
