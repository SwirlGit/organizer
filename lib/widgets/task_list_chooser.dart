import 'package:flutter/material.dart';

import 'package:organizer/widgets/task_item.dart';
import 'package:organizer/models/task_model.dart';

class TaskListChooser extends StatelessWidget {
  final List<Task> tasks;

  TaskListChooser({
    @required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        final task = tasks[index];
        return TaskItem(
          task: task,
          onTap: () {
            Navigator.pop(context, task);
          },
        );
      },
    );
  }
}
