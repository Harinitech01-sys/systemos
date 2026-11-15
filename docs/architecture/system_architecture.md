# HariniOS System Architecture

## Layered structure
HariniOS follows a feature-first clean architecture with a small shared core layer:

- `lib/core/` – application-wide utilities, constants, style, error handling, and shared infrastructure.
- `lib/shared/` – reusable UI components or shared domain helpers when needed.
- `lib/features/` – each feature is organized into its own `data/`, `domain/`, and `presentation/` folders.

## Current foundation
This project starts with a minimal but scalable structure:

- `main.dart` is a thin bootstrap that starts the app.
- `app.dart` defines the application shell and startup screen.
- `core/theme/` contains the Material 3 light and dark themes.
- `core/error/` contains the app-level error-handling strategy.
- `core/constants/` stores app-wide spacing and palette values.

## Architectural principles
- Keep business rules outside the UI layer.
- Use separate repositories for persistence logic.
- Make database access local and explicit.
- Build reusable widgets instead of one-off UI blocks.
- Keep the initial layers simple and easy to extend.

## Day 1 outcome
The app is now ready for future feature modules to plug into a consistent design system and navigation foundation.
