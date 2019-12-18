import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

import 'package:organizer/models/task_model.dart';

import 'package:organizer/widgets/task_item.dart';
import 'package:organizer/widgets/task_list_adder.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task task;
  final TaskAdder addTask;
  final TaskRemover removeTask;
  final TaskUpdater updateTask;

  AddEditTaskScreen({
    @required this.addTask,
    @required this.removeTask,
    @required this.updateTask,
    this.task,
  });

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

const String MIN_DATETIME = '2019-01-01 00:00:00';
const String MAX_DATETIME = '2100-12-31 23:59:59';
const String DATETIME_FORMAT = 'yyyy-MM-dd HH:mm:ss';

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _targetDateTimeController =
      new TextEditingController();
  DateTime _targetDateTime;
  String _name;
  String _text;

  @override
  void initState() {
    _targetDateTime =
        widget.task != null ? widget.task.dateInformation.targetDate : null;
    _targetDateTimeController.text = _currentTargetDateTimeString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'edit task' : 'add task')),
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
                initialValue: widget.task != null ? widget.task.name : '',
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                  hintText: 'Task title',
                ),
                validator: (val) =>
                    val.trim().isEmpty ? 'Please enter task title' : null,
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
                initialValue: widget.task != null ? widget.task.text : '',
                maxLines: 10,
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'Task text',
                ),
                onSaved: (value) => _text = value,
              ),
              TaskListAdder(
                maxItems: 1,
                title: 'Parent task',
                tasks: widget.task == null || widget.task.parentTask == null
                    ? []
                    : [widget.task.parentTask],
                loading: false,
                addTask: widget.addTask,
                removeTask: widget.removeTask,
                updateTask: widget.updateTask,
              ),
              TaskListAdder(
                maxItems: -1,
                title: 'Sub tasks',
                tasks: widget.task == null || widget.task.subTasks == null
                    ? []
                    : widget.task.subTasks,
                loading: false,
                addTask: widget.addTask,
                removeTask: widget.removeTask,
                updateTask: widget.updateTask,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: isEditing ? 'Save changes' : 'Add task',
          child: Icon(isEditing ? Icons.check : Icons.add),
          onPressed: () {
            final form = formKey.currentState;
            if (form.validate()) {
              form.save();

              final targetDateTime = _targetDateTime.toUtc();
              final name = _name;
              final text = _text;

              if (isEditing) {
                widget.updateTask(widget.task,
                    name: name, targetDate: targetDateTime, text: text);
              } else {
                widget.addTask(Task(
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
      pickerMode: DateTimePickerMode.datetime,
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
    }
    return '';
  }

  bool get isEditing => widget.task != null;
}
