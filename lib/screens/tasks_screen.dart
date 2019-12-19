import 'package:flutter/material.dart';

import 'package:organizer/models/app_state_model.dart';
import 'package:organizer/models/task_model.dart';
import 'package:organizer/widgets/task_list.dart';

class TasksScreen extends StatefulWidget {
  final AppState appState;
  final TaskAdder addTask;
  final TasksFinder possibleParents;
  final TasksFinder possibleSubs;
  final TaskRemover removeTask;
  final TaskUpdater updateTask;

  TasksScreen({
    @required this.appState,
    @required this.addTask,
    @required this.possibleParents,
    @required this.possibleSubs,
    @required this.removeTask,
    @required this.updateTask,
  });

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: TaskList(
        tasks: widget.appState.tasks,
        loading: widget.appState.isLoading,
        addTask: widget.addTask,
        possibleParents: widget.possibleParents,
        possibleSubs: widget.possibleSubs,
        removeTask: widget.removeTask,
        updateTask: widget.updateTask,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/tasks/addTask');
        },
        child: Icon(Icons.add),
        tooltip: 'Add task',
      ),
    );
  }
}
