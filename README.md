# HariniOS

HariniOS is a personal life-management system built with Flutter and Material 3. This repository is being developed in focused daily milestones, starting with the Day 1 foundation.

## Current project status
- App foundation is established.
- Material 3 light and dark themes are configured.
- Shared constants and startup error handling are in place.
- The application launches with a clean startup screen for the initial app shell.

## Project structure
- `lib/app.dart` – application root and startup shell
- `lib/core/` – reusable app-wide logic, constants, and theme definitions
- `lib/features/` – feature-first expansion area for future modules
- `docs/` – planning, documentation, and development history

## Run locally
```bash
flutter pub get
flutter run
```

## Day 1 verification
- `dart format lib test`
- `flutter analyze`
- `flutter test`

## Environment note
The local desktop launch check is currently blocked by a missing Visual Studio toolchain on this machine. The app code itself is passing the repository’s analyzer and widget tests.

See the planning and architecture notes in the `docs/` folder for the current direction and daily progress.
