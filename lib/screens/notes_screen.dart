import 'package:flutter/material.dart';

import 'package:organizer/models/app_state_model.dart';
import 'package:organizer/models/note_model.dart';
import 'package:organizer/widgets/note_list.dart';

class NotesScreen extends StatefulWidget {
  final AppState appState;
  final NoteAdder addNote;
  final NoteRemover removeNote;
  final NoteUpdater updateNote;

  NotesScreen({
    @required this.appState,
    @required this.addNote,
    @required this.removeNote,
    @required this.updateNote,
  });

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: NoteList(
        notes: widget.appState.notes,
        loading: widget.appState.isLoading,
        removeNote: widget.removeNote,
        addNote: widget.addNote,
        updateNote: widget.updateNote,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/notes/addNote');
        },
        child: Icon(Icons.add),
        tooltip: 'Add note',
      ),
    );
  }
}
