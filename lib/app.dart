import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:organizer/common/theme.dart';

import 'package:organizer/models/app_state_model.dart';
import 'package:organizer/models/note_model.dart';

import 'package:organizer/screens/add_edit_note_screen.dart';
import 'package:organizer/screens/home_screen.dart';
import 'package:organizer/screens/notes_screen.dart';

class OrganizerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OrganizerAppState();
}

class OrganizerAppState extends State<OrganizerApp> {
  AppState appState = AppState.loading();

  @override
  void initState() {
    super.initState();
    _load().then((Map<String, dynamic> json) {
      setState(() {
        appState = AppState.fromJson(json);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organizer',
      theme: OrganizerTheme.theme,
      home: PageView(
        children: <Widget>[
          HomeScreen(),
          NotesScreen(
            appState: appState,
            updateNote: updateNote,
            addNote: addNote,
            removeNote: removeNote,
          ),
        ],
      ),
      routes: {
        '/notes/addNote': (context) {
          return AddEditNoteScreen(
            addNote: addNote,
            updateNote: updateNote,
          );
        },
      },
    );
  }

  Future<Map<String, dynamic>> _load() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/app_state.txt');
      final text = await file.readAsString();
      final jsonState = json.decode(text);
      return jsonState;
    } catch (e) {
      print("Couldn't read file");
    }
    return null;
  }

  void _save() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/app_state.txt');
      final text = json.encode(appState.toJson());
      await file.writeAsString(text);
    } catch (e) {
      print("Couldn't save to file");
    }
  }

  void addNote(Note note) {
    setState(() {
      appState.notes.add(note);
    });
  }

  void removeNote(Note note) {
    setState(() {
      appState.notes.remove(note);
    });
  }

  void updateNote(
    Note note, {
    String id,
    String name,
    String text,
  }) {
    setState(() {
      note.id = id ?? note.id;
      note.name = name ?? note.name;
      note.text = text ?? note.text;
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    _save();
  }
}
