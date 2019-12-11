import 'package:flutter/material.dart';

import 'package:organizer/widgets/todo_item.dart';
import 'package:organizer/models/todo_model.dart';
import 'package:organizer/screens/add_edit_todo_screen.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final bool loading;
  final TodoAdder addTodo;
  final TodoRemover removeTodo;
  final TodoUpdater updateTodo;

  TodoList({
    @required this.todos,
    @required this.loading,
    @required this.addTodo,
    @required this.removeTodo,
    @required this.updateTodo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          final todo = todos[index];

          return TodoItem(
            todo: todo,
            onDismissed: (direction) {
              removeTodo(todo);
            },
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddEditTodoScreen(
                    addTodo: addTodo,
                    updateTodo: updateTodo,
                    todo: todo,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}