import 'package:flutter/material.dart';

import 'package:organizer/models/note_model.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note note;
  final NoteAdder addNote;
  final NoteUpdater updateNote;

  AddEditNoteScreen({
    @required this.addNote,
    @required this.updateNote,
    this.note,
  });

  @override
  _AddEditNoteScreenState createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _name;
  String _text;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'edit note' : 'add note')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              initialValue: widget.note != null ? widget.note.name : '',
              style: Theme.of(context).textTheme.headline,
              decoration: InputDecoration(
                hintText: 'Note title',
              ),
              validator: (val) =>
                  val.trim().isEmpty ? 'Please enter note title' : null,
              onSaved: (value) => _name = value,
            ),
            TextFormField(
              initialValue: widget.note != null ? widget.note.text : '',
              style: Theme.of(context).textTheme.subhead,
              decoration: InputDecoration(
                hintText: 'Note text',
              ),
              onSaved: (value) => _text = value,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: isEditing ? 'Save changes' : 'Add note',
          child: Icon(isEditing ? Icons.check : Icons.add),
          onPressed: () {
            final form = formKey.currentState;
            if (form.validate()) {
              form.save();

              final name = _name;
              final text = _text;

              if (isEditing) {
                widget.updateNote(widget.note, name: name, text: text);
              } else {
                widget.addNote(Note(
                  name,
                  text: text,
                ));
              }

              Navigator.pop(context);
            }
          }),
    );
  }

  bool get isEditing => widget.note != null;
}
