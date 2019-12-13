import 'package:flutter/material.dart';

import 'package:organizer/models/task_model.dart';

class TaskItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Task task;

  TaskItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('NoteItem__${task.id}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Text(
          task.name,
          style: Theme.of(context).textTheme.title,
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