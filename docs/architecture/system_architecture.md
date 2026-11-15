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

## Navigation
- `core/navigation/app_router.dart` defines the app routes using GoRouter.
- `core/navigation/app_shell.dart` hosts a stateful shell with five bottom-navigation destinations.
- Each destination has its own feature presentation screen; shared placeholder UI lives in `shared/widgets/`.
- The indexed shell preserves each destination's navigation state when switching tabs.

## Day 2 outcome
The application now starts at Home and navigates between Home, Plan, Add, Insights, and Settings. These screens are placeholders for later milestones, not fake data-backed functionality.

## Dashboard preview data
- `features/home/data/dashboard_preview_data.dart` contains typed, in-memory sample data and an empty data set for dashboard previews and empty states.
- `features/home/presentation/home_screen.dart` composes the dashboard and routes quick actions into the existing Plan, Add, and Settings destinations.
- `features/home/presentation/widgets/dashboard_sections.dart` contains the dashboard's reusable sections and their empty states.
- The dashboard labels the preview as sample content; it is not connected to storage and is not presented as saved user data.

## Day 3 outcome
Home now presents a responsive, scrollable dashboard with a time-aware greeting, date, daily progress, today's tasks, habit check-in, study progress, daily goals, and quick actions. Day 4 will introduce real local data persistence.
