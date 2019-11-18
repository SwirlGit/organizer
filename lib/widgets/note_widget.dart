import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organizer',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Organizer'),
        ),
        body: _buildNotes(),
      ),
    );
  }

  Widget _buildNotes() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 1,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          return _buildRow("");
        });
  }

  Widget _buildRow(String name) {
    return ListTile(
      title: Text(
        name,
      ),
      trailing: Icon(
        Icons.check,
        color: Colors.green,
      ),
    );
  }
}
