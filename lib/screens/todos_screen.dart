import 'package:flutter/material.dart';

import 'package:organizer/models/app_state_model.dart';
import 'package:organizer/models/todo_model.dart';
import 'package:organizer/widgets/todo_list.dart';

class TodosScreen extends StatefulWidget {
  final AppState appState;
  final TodoAdder addTodo;
  final TodoRemover removeTodo;
  final TodoUpdater updateTodo;

  TodosScreen({
    @required this.appState,
    @required this.addTodo,
    @required this.removeTodo,
    @required this.updateTodo,
  });

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: TodoList(
        todos: widget.appState.todos,
        loading: widget.appState.isLoading,
        removeTodo: widget.removeTodo,
        addTodo: widget.addTodo,
        updateTodo: widget.updateTodo,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/todos/addTodo');
        },
        child: Icon(Icons.add),
        tooltip: 'Add todo',
      ),
    );
  }
}