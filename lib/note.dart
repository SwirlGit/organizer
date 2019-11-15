import 'package:flutter/material.dart';

class NoteState extends State<Note> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note'),
      ),
      body: TextFormField(
        controller: textController,
      ),
    );
  }
}

class Note extends StatefulWidget {
  @override
  NoteState createState() => NoteState();
}