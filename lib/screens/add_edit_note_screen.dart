import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

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

const String MIN_DATETIME = '2019-01-01 00:00:00';
const String MAX_DATETIME = '2100-12-31 23:59:59';
const String DATETIME_FORMAT = 'yyyy-MM-dd HH:mm:ss';

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime _targetDateTime;
  String _name;
  String _text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'edit note' : 'add note')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidate: false,
          onWillPop: () {
            return Future(() => true);
          },
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
              FlatButton(
                onPressed: () {
                  _showDateTimePicker();
                },
                child: Text(_currentTargetDateTimeString()),
              ),
              TextFormField(
                initialValue: widget.note != null ? widget.note.text : '',
                maxLines: 10,
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'Note text',
                ),
                onSaved: (value) => _text = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: isEditing ? 'Save changes' : 'Add note',
          child: Icon(isEditing ? Icons.check : Icons.add),
          onPressed: () {
            final form = formKey.currentState;
            if (form.validate()) {
              form.save();

              final targetDateTime = _targetDateTime.toUtc();
              final name = _name;
              final text = _text;

              if (isEditing) {
                widget.updateNote(widget.note, name: name, text: text);
              } else {
                widget.addNote(Note(
                  name,
                  targetDate: targetDateTime,
                  text: text,
                ));
              }
              Navigator.pop(context);
            }
          }),
    );
  }

  void _showDateTimePicker() {
    DatePicker.showDatePicker(
      context,
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      //initialDateTime: DateTime.parse(INIT_DATETIME),
      dateFormat: DATETIME_FORMAT,
      //locale: _locale,
      pickerMode: DateTimePickerMode.datetime, // show DateTimePicker
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _targetDateTime = dateTime;
        });
      },
    );
  }

  String _currentTargetDateTimeString() {
    String resultString;
    if (widget.note == null) {
      if (_targetDateTime == null) {
        resultString = 'target date time';
      } else {
        resultString = _targetDateTime.toLocal().toString();
      }
    } else {
      if (_targetDateTime == null) {
        resultString = widget.note.dateInformation.targetDate.toLocal().toString();
      } else {
        resultString = _targetDateTime.toLocal().toString();
      }
    }
    return resultString;
  }

  bool get isEditing => widget.note != null;
}
