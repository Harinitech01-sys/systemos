import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../data/dashboard_preview_data.dart';

class DashboardSectionTitle extends StatelessWidget {
  const DashboardSectionTitle({required this.title, this.trailing, super.key});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xl, bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class DashboardEmptyState extends StatelessWidget {
  const DashboardEmptyState({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(message, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class DailyProgressCard extends StatelessWidget {
  const DailyProgressCard({required this.data, super.key});

  final DashboardPreviewData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = data.tasks.isEmpty
        ? 0.0
        : data.completedTasks / data.tasks.length;

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "TODAY'S PROGRESS",
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                letterSpacing: 1.1,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: Text(
                    data.tasks.isEmpty
                        ? 'A fresh start'
                        : '${data.completedTasks} of ${data.tasks.length} tasks done',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ClipRRect(
              borderRadius: AppBorderRadius.small,
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: theme.colorScheme.onPrimary.withValues(
                  alpha: 0.2,
                ),
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Small steps make a meaningful day.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodaysTasksCard extends StatelessWidget {
  const TodaysTasksCard({required this.tasks, super.key});

  final List<PreviewTask> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const DashboardEmptyState(
        message: 'Nothing planned yet. Enjoy the breathing room.',
      );
    }

    return Card(
      child: Column(
        children: [
          for (var index = 0; index < tasks.length; index++) ...[
            _TaskRow(task: tasks[index]),
            if (index < tasks.length - 1)
              const Divider(indent: AppSpacing.lg, endIndent: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({required this.task});

  final PreviewTask task;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Icon(
            task.isDone
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: task.isDone
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              task.title,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: task.isDone ? theme.colorScheme.onSurfaceVariant : null,
                decoration: task.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(task.time, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}

class HabitOverviewCard extends StatelessWidget {
  const HabitOverviewCard({required this.habits, super.key});

  final List<PreviewHabit> habits;

  @override
  Widget build(BuildContext context) {
    if (habits.isEmpty) {
      return const DashboardEmptyState(
        message: 'Your habit check-in will show up here.',
      );
    }
    final theme = Theme.of(context);
    final completed = habits.where((habit) => habit.isDone).length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$completed of ${habits.length} habits checked in',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [for (final habit in habits) _HabitChip(habit: habit)],
            ),
          ],
        ),
      ),
    );
  }
}

class _HabitChip extends StatelessWidget {
  const _HabitChip({required this.habit});

  final PreviewHabit habit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = habit.isDone
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.surfaceContainerHighest;

    return Container(
      constraints: const BoxConstraints(maxWidth: 260),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppBorderRadius.large,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            habit.isDone ? Icons.check_rounded : Icons.circle_outlined,
            size: 18,
            color: habit.isDone
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(child: Text(habit.title, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

class StudyProgressCard extends StatelessWidget {
  const StudyProgressCard({
    required this.minutes,
    required this.targetMinutes,
    super.key,
  });

  final int minutes;
  final int targetMinutes;

  @override
  Widget build(BuildContext context) {
    if (targetMinutes <= 0) {
      return const DashboardEmptyState(
        message: 'Add a study target to see your progress here.',
      );
    }
    final theme = Theme.of(context);
    final progress = (minutes / targetMinutes).clamp(0.0, 1.0);
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.menu_book_rounded, color: theme.colorScheme.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  hours > 0
                      ? '$hours hr $remainingMinutes min studied'
                      : '$minutes min studied',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ClipRRect(
              borderRadius: AppBorderRadius.small,
              child: LinearProgressIndicator(value: progress, minHeight: 8),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Daily target: $targetMinutes minutes',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class DailyGoalsCard extends StatelessWidget {
  const DailyGoalsCard({required this.goals, super.key});

  final List<PreviewGoal> goals;

  @override
  Widget build(BuildContext context) {
    if (goals.isEmpty) {
      return const DashboardEmptyState(
        message: 'Choose one small thing to make today count.',
      );
    }

    return Card(
      child: Column(
        children: [
          for (var index = 0; index < goals.length; index++) ...[
            _GoalRow(goal: goals[index]),
            if (index < goals.length - 1)
              const Divider(indent: AppSpacing.lg, endIndent: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}

class _GoalRow extends StatelessWidget {
  const _GoalRow({required this.goal});

  final PreviewGoal goal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Icon(
            goal.isDone ? Icons.check_circle_rounded : Icons.flag_outlined,
            color: goal.isDone
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              goal.title,
              style: theme.textTheme.bodyLarge?.copyWith(
                decoration: goal.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
