import 'package:flutter/material.dart';

import 'package:organizer/models/task_model.dart';
import 'package:organizer/widgets/task_item.dart';

class ChooseTaskScreen extends StatelessWidget {
  final List<Task> tasks;

  ChooseTaskScreen({
    @required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose task')),
      body: ListView.builder(
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
      ),
    );
  }
}
