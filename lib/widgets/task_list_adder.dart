import 'package:flutter/material.dart';

import 'package:organizer/models/task_model.dart';

import 'package:organizer/widgets/task_item.dart';

class TaskListAdder extends StatelessWidget {
  final int maxItems;
  final String title;
  final List<Task> tasks;
  final Function(Task task) onTap;
  final Function(Task task) onDoneTap;
  final Function(Task task) onDeleteTap;
  final GestureTapCallback onAddTap;

  TaskListAdder({
    @required this.maxItems,
    @required this.title,
    @required this.tasks,
    @required this.onTap,
    @required this.onAddTap,
    this.onDoneTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(title),
              ((maxItems >= 0) && (tasks.length >= maxItems))
                  ? Container()
                  : IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: onAddTap,
                    ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              final task = tasks[index];
              return TaskItem(
                task: task,
                onDeleteTap:
                    onDeleteTap == null ? null : () => onDeleteTap(task),
                onDoneTap: onDoneTap == null ? null : () => onDoneTap(task),
                onTap: () => onTap(task),
              );
            },
          ),
        ],
      ),
    );
  }
}
