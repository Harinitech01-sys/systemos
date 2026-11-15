import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../tasks/domain/task_repository.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({required this.repository, super.key});

  final TaskRepository repository;

  Future<void> _editTask(BuildContext context, int id, String title) async {
    final controller = TextEditingController(text: title);
    final newTitle = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit task'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 160,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(labelText: 'Task title'),
          onSubmitted: (value) => Navigator.of(context).pop(value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();

    if (newTitle == null || !context.mounted) {
      return;
    }
    try {
      final updated = await repository.updateTaskTitle(id, newTitle);
      if (!updated && context.mounted) {
        _showMessage(context, 'This task no longer exists.');
      }
    } catch (error) {
      if (context.mounted) {
        _showMessage(context, 'Could not update task: $error');
      }
    }
  }

  Future<void> _setCompleted(
    BuildContext context,
    int id,
    bool isCompleted,
  ) async {
    try {
      await repository.setTaskCompleted(id, isCompleted);
    } catch (error) {
      if (context.mounted) {
        _showMessage(context, 'Could not update task: $error');
      }
    }
  }

  Future<void> _deleteTask(BuildContext context, int id) async {
    try {
      await repository.deleteTask(id);
    } catch (error) {
      if (context.mounted) {
        _showMessage(context, 'Could not delete task: $error');
      }
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your plan')),
      body: SafeArea(
        child: StreamBuilder(
          stream: repository.watchTasks(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    'Could not load tasks: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final tasks = snapshot.data!;
            if (tasks.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.checklist_rounded,
                        size: 48,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Nothing planned yet.',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Add a task to start shaping your day.',
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: tasks.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  child: CheckboxListTile(
                    value: task.isCompleted,
                    onChanged: (value) =>
                        _setCompleted(context, task.id, value ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      task.title,
                      style: task.isCompleted
                          ? theme.textTheme.bodyLarge?.copyWith(
                              decoration: TextDecoration.lineThrough,
                            )
                          : null,
                    ),
                    secondary: PopupMenuButton<String>(
                      tooltip: 'Task actions',
                      onSelected: (action) {
                        if (action == 'edit') {
                          _editTask(context, task.id, task.title);
                        } else if (action == 'delete') {
                          _deleteTask(context, task.id);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
