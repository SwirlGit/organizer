import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:organizer/screens/add_edit_todo_screen.dart';
import 'package:organizer/screens/todos_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'package:organizer/common/theme.dart';

import 'package:organizer/models/app_state_model.dart';
import 'package:organizer/models/note_model.dart';
import 'package:organizer/models/todo_model.dart';

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
          TodosScreen(
            appState: appState,
            updateTodo: updateTodo,
            addTodo: addTodo,
            removeTodo: removeTodo,
          ),
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
        '/todos/addTodo': (context) {
          return AddEditTodoScreen(
            addTodo: addTodo,
            updateTodo: updateTodo,
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
    DateTime targetDate,
    String name,
    String text,
  }) {
    setState(() {
      note.id = id ?? note.id;
      note.dateInformation.targetDate =
          targetDate ?? note.dateInformation.targetDate;
      note.name = name ?? note.name;
      note.text = text ?? note.text;
    });
  }

  void addTodo(Todo todo) {
    setState(() {
      appState.todos.add(todo);
    });
  }

  void removeTodo(Todo todo) {
    setState(() {
      appState.todos.remove(todo);
    });
  }

  void updateTodo(
    Todo todo, {
    String id,
    DateTime targetDate,
    String name,
    String text,
  }) {
    setState(() {
      todo.id = id ?? todo.id;
      todo.dateInformation.targetDate =
          targetDate ?? todo.dateInformation.targetDate;
      todo.name = name ?? todo.name;
      todo.text = text ?? todo.text;
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    _save();
  }
}
