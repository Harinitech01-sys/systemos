import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../data/dashboard_preview_data.dart';
import 'widgets/dashboard_sections.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({this.data = DashboardPreviewData.sample, super.key});

  final DashboardPreviewData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: CustomScrollView(
              key: const ValueKey('home-dashboard-scroll'),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.xxl,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _DashboardHeader(),
                      const SizedBox(height: AppSpacing.md),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondaryContainer,
                            borderRadius: AppBorderRadius.large,
                          ),
                          child: Text(
                            'SAMPLE PREVIEW · NOT SAVED',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      DailyProgressCard(data: data),
                      const DashboardSectionTitle(title: 'Quick actions'),
                      const _QuickActions(),
                      DashboardSectionTitle(
                        title: "Today's tasks",
                        trailing: TextButton(
                          onPressed: () => context.go('/plan'),
                          child: const Text('See plan'),
                        ),
                      ),
                      TodaysTasksCard(tasks: data.tasks),
                      const DashboardSectionTitle(title: 'Habit check-in'),
                      HabitOverviewCard(habits: data.habits),
                      const DashboardSectionTitle(title: 'Study progress'),
                      StudyProgressCard(
                        minutes: data.studyMinutes,
                        targetMinutes: data.studyTargetMinutes,
                      ),
                      const DashboardSectionTitle(title: 'Daily goals'),
                      DailyGoalsCard(goals: data.goals),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  _DashboardHeader();

  final DateTime _today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greeting(_today.hour),
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _formattedDate(_today),
                  key: const ValueKey('dashboard-date'),
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Open settings',
            onPressed: () => context.go('/settings'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
    );
  }

  String _greeting(int hour) {
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  String _formattedDate(DateTime date) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} '
        '${date.day}';
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () => context.go('/add'),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add a task'),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => context.go('/plan'),
            icon: const Icon(Icons.calendar_today_outlined),
            label: const Text('View plan'),
          ),
        ),
      ],
    );
  }
}
