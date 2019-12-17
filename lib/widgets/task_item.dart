import 'package:flutter/material.dart';

import 'package:organizer/models/task_model.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final GestureTapCallback onTap;
  final GestureTapCallback onDoneTap;
  final GestureTapCallback onDeleteTap;

  TaskItem({
    @required this.task,
    @required this.onTap,
    this.onDoneTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        task.name,
        style: Theme.of(context).textTheme.title,
      ),
      trailing: _icons(),
      subtitle: Text(
        task.text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subhead,
      ),
    );
  }

  Row _icons() {
    var iconWidgets = new List<Widget>();
    if (onDoneTap != null) {
      iconWidgets.add(
        IconButton(
          icon: Icon(
            Icons.check,
            color: task.done ? Colors.green : Colors.grey,
          ),
          onPressed: onDoneTap,
        ),
      );
    }
    if (onDeleteTap != null) {
      iconWidgets.add(
        IconButton(
          icon: Icon(Icons.delete, color: Colors.grey),
          onPressed: onDeleteTap,
        ),
      );
    }
    return Row(children: iconWidgets, mainAxisSize: MainAxisSize.min);
  }
}
