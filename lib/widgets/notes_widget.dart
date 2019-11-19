import 'package:flutter/material.dart';

import 'package:organizer/widgets/note_item.dart';
import 'package:organizer/models/note_model.dart';
import 'package:organizer/screens/actions_screen.dart';
import 'package:organizer/screens/add_edit_note_screen.dart';

class NotesWidget extends StatelessWidget {
  final List<Note> notes;
  final bool loading;
  final NoteAdder addNote;
  final NoteRemover removeNote;
  final NoteUpdater updateNote;

  NotesWidget({
    @required this.notes,
    @required this.loading,
    @required this.addNote,
    @required this.removeNote,
    @required this.updateNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                final note = notes[index];

                return NoteItem(
                  note: note,
                  onDismissed: (direction) {
                    removeNote(note);
                  },
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) {
                        return ActionsScreen(
                          object: note,
                          onDelete: removeNote,
                          widget: AddEditNoteScreen(
                            addNote: addNote,
                            updateNote: updateNote,
                          ),
                        );
                      },
                    ));
                  },
                );
              },
            ),
    );
  }
}
