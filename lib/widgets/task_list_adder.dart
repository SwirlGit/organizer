import 'package:flutter/material.dart';

import 'package:organizer/widgets/task_item.dart';
import 'package:organizer/models/task_model.dart';
import 'package:organizer/screens/add_edit_task_screen.dart';

class TaskListAdder extends StatelessWidget {
  final int maxItems;
  final String title;
  final List<Task> tasks;
  final bool loading;
  final TaskAdder addTask;
  final TaskRemover removeTask;
  final TaskUpdater updateTask;

  TaskListAdder({
    @required this.maxItems,
    @required this.title,
    @required this.tasks,
    @required this.loading,
    @required this.addTask,
    @required this.removeTask,
    @required this.updateTask,
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/tasks/chooseTask');
                      },
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
                onDeleteTap: () => removeTask(task),
                onDoneTap: () => updateTask(task, done: !task.done),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddEditTaskScreen(
                        addTask: addTask,
                        updateTask: updateTask,
                        task: task,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
