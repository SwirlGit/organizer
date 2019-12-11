import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

import 'package:organizer/models/todo_model.dart';

class AddEditTodoScreen extends StatefulWidget {
  final Todo todo;
  final TodoAdder addTodo;
  final TodoUpdater updateTodo;

  AddEditTodoScreen({
    @required this.addTodo,
    @required this.updateTodo,
    this.todo,
  });

  @override
  _AddEditTodoScreenState createState() => _AddEditTodoScreenState();
}

const String MIN_DATETIME = '2019-01-01 00:00:00';
const String MAX_DATETIME = '2100-12-31 23:59:59';
const String DATETIME_FORMAT = 'yyyy-MM-dd HH:mm:ss';

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _targetDateTimeController =
  new TextEditingController();
  DateTime _targetDateTime;
  String _name;
  String _text;

  @override
  void initState() {
    _targetDateTimeController.text = _currentTargetDateTimeString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'edit todo' : 'add todo')),
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
                initialValue: widget.todo != null ? widget.todo.name : '',
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                  hintText: 'Todo title',
                ),
                validator: (val) =>
                val.trim().isEmpty ? 'Please enter todo title' : null,
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                controller: _targetDateTimeController,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                  hintText: 'Target date',
                ),
                validator: (val) {
                  try {
                    DateTime.parse(val);
                    return null;
                  } catch (e) {
                    return 'Please choose target date time';
                  }
                },
                onTap: () {
                  _showDateTimePicker();
                },
              ),
              TextFormField(
                initialValue: widget.todo != null ? widget.todo.text : '',
                maxLines: 10,
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'Todo text',
                ),
                onSaved: (value) => _text = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: isEditing ? 'Save changes' : 'Add todo',
          child: Icon(isEditing ? Icons.check : Icons.add),
          onPressed: () {
            final form = formKey.currentState;
            if (form.validate()) {
              form.save();

              final targetDateTime = _targetDateTime.toUtc();
              final name = _name;
              final text = _text;

              if (isEditing) {
                widget.updateTodo(widget.todo,
                    name: name, targetDate: targetDateTime, text: text);
              } else {
                widget.addTodo(Todo(
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
      dateFormat: DATETIME_FORMAT,
      pickerMode: DateTimePickerMode.datetime, // show DateTimePicker
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _targetDateTime = dateTime;
          _targetDateTimeController.text = _currentTargetDateTimeString();
        });
      },
    );
  }

  String _currentTargetDateTimeString() {
    if (_targetDateTime != null) {
      return DateFormat(DATETIME_FORMAT).format(_targetDateTime.toLocal());
    } else if (widget.todo != null) {
      return DateFormat(DATETIME_FORMAT)
          .format(widget.todo.dateInformation.targetDate.toLocal());
    }
    return '';
  }

  bool get isEditing => widget.todo != null;
}