import 'package:flutter/material.dart';

class ActionsScreen extends StatelessWidget {
  final Object object;
  final Function onDelete;
  final Widget widget;

  ActionsScreen({
    @required this.object,
    @required this.onDelete,
    @required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('actions'), actions: [
      IconButton(
          tooltip: 'edit',
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return widget;
                  }
                )
            );
          }),
      IconButton(
        tooltip: 'delete',
        icon: Icon(Icons.delete),
        onPressed: () {
          onDelete(object);
          Navigator.pop(context, object);
        },
      )
    ]);
  }
}
