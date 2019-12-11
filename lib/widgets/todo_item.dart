import 'package:flutter/material.dart';

import 'package:organizer/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Todo todo;

  TodoItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('NoteItem__${todo.id}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Text(
          todo.name,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          todo.text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }
}