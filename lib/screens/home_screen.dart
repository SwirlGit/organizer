import 'package:flutter/material.dart';

import 'package:organizer/models/app_state_model.dart';
import 'package:organizer/models/note_model.dart';

class HomeScreen extends StatefulWidget {
  final AppState appState;
  final NoteAdder addNote;
  final NoteRemover removeNote;
  final NoteUpdater updateNote;

  HomeScreen({
    @required this.appState,
    @required this.addNote,
    @required this.removeNote,
    @required this.updateNote,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
