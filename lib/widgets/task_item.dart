import 'package:flutter/material.dart';

import 'package:organizer/models/task_model.dart';

class TaskItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final GestureTapCallback onDoneTap;
  final Task task;

  TaskItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.onDoneTap,
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('TaskItem__${task.id}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Text(
          task.name,
          style: Theme.of(context).textTheme.title,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.check,
            color: task.done ? Colors.green : Colors.grey,
          ),
          onPressed: onDoneTap,
        ),
        subtitle: Text(
          task.text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }
}
