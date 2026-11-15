# HariniOS Project Vision

HariniOS is a private life-management system designed to help one person organize work, health, learning, goals, money, and daily routines in a single calm digital space.

## Core values
- Privacy-first personal use, not a commercial SaaS product.
- Minimal, premium, and low-friction experience.
- One place for everyday planning, reflection, and accountability.
- Local-first data storage with future support for private sync only if needed.

## Planned feature areas
1. Dashboard
2. Tasks and reminders
3. Notes and knowledge management
4. Personal diary
5. Mood and stress tracker
6. Money manager
7. Screen-time tracker
8. Habit tracker
9. Study and career planner
10. Health and lifestyle tracker
11. Goals and personal growth
12. Reading tracker
13. Projects and idea vault
14. Analytics and reports
15. Personal AI assistant

## Design direction
- Android-first user experience.
- Material 3 design system.
- Clean cards, soft surfaces, and consistent spacing.
- Calm colors and strong readability.
- Functional focus over decorative complexity.

## Day 1 focus
The first milestone establishes the app foundation: theme system, app entry point, safe startup structure, and a simple error-handling strategy.

## Day 2 focus
The second milestone adds GoRouter navigation, a persistent five-destination app shell, and separate placeholder screens. The Home destination is intentionally left ready for the Day 3 dashboard.

## Day 3 focus
The Home destination becomes a responsive dashboard with a time-aware greeting, current date, daily progress, tasks, habit check-in, study progress, daily goals, and quick actions. Its clearly labeled sample preview data remains separate from persisted user data.

## Day 4 focus
Add a local SQLite foundation and persist task creation, reading, updates, completion, and deletion through a repository.
