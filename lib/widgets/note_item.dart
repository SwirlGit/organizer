import 'package:flutter/material.dart';

import 'package:organizer/models/note_model.dart';

class NoteItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Note note;

  NoteItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('NoteItem__${note.id}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Text(
          note.name,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          note.text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }
}