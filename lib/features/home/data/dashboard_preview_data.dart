class DashboardPreviewData {
  const DashboardPreviewData({
    required this.tasks,
    required this.habits,
    required this.goals,
    required this.studyMinutes,
    required this.studyTargetMinutes,
  });

  static const sample = DashboardPreviewData(
    tasks: [
      PreviewTask(
        title: 'Review weekly priorities',
        time: '9:30 AM',
        isDone: true,
      ),
      PreviewTask(title: 'Finish biology notes', time: '11:00 AM'),
      PreviewTask(title: 'Plan tomorrow', time: '4:30 PM'),
    ],
    habits: [
      PreviewHabit(title: 'Drink water', isDone: true),
      PreviewHabit(title: 'Read 20 min', isDone: true),
      PreviewHabit(title: 'Morning stretch', isDone: false),
      PreviewHabit(title: 'Journal', isDone: false),
    ],
    goals: [
      PreviewGoal(title: 'Move my body', isDone: true),
      PreviewGoal(title: 'Make time to read', isDone: false),
    ],
    studyMinutes: 45,
    studyTargetMinutes: 90,
  );

  static const empty = DashboardPreviewData(
    tasks: [],
    habits: [],
    goals: [],
    studyMinutes: 0,
    studyTargetMinutes: 0,
  );

  final List<PreviewTask> tasks;
  final List<PreviewHabit> habits;
  final List<PreviewGoal> goals;
  final int studyMinutes;
  final int studyTargetMinutes;

  int get completedTasks => tasks.where((task) => task.isDone).length;
  int get completedHabits => habits.where((habit) => habit.isDone).length;
  int get completedGoals => goals.where((goal) => goal.isDone).length;
}

class PreviewTask {
  const PreviewTask({
    required this.title,
    required this.time,
    this.isDone = false,
  });

  final String title;
  final String time;
  final bool isDone;
}

class PreviewHabit {
  const PreviewHabit({required this.title, required this.isDone});

  final String title;
  final bool isDone;
}

class PreviewGoal {
  const PreviewGoal({required this.title, required this.isDone});

  final String title;
  final bool isDone;
}
