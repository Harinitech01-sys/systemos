import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../tasks/domain/task_repository.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({required this.repository, super.key});

  final TaskRepository repository;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _titleController = TextEditingController();
  String? _errorMessage;
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      setState(() => _errorMessage = 'Enter a task title.');
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      await widget.repository.addTask(title);
      if (!mounted) return;
      _titleController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Task saved.')));
    } catch (error) {
      if (mounted) {
        setState(() => _errorMessage = 'Could not save task: $error');
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add a task')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                Text(
                  'Capture one thing you want to get done.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextField(
                  key: const ValueKey('task-title-input'),
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  maxLength: 160,
                  onSubmitted: (_) => _saveTask(),
                  decoration: const InputDecoration(
                    labelText: 'Task title',
                    hintText: 'e.g. Review weekly priorities',
                  ),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _errorMessage!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                FilledButton.icon(
                  key: const ValueKey('save-task-button'),
                  onPressed: _isSaving ? null : _saveTask,
                  icon: _isSaving
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check_rounded),
                  label: Text(_isSaving ? 'Saving…' : 'Save task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
