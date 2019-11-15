import 'package:flutter/material.dart';

void main() => runApp(Organizer());

class Organizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Organizer'),
        ),
        body: Center(
          child: Text('Orginize'),
        ),
      ),
    );
  }
}
