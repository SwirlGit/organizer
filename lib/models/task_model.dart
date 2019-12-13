import 'package:organizer/common/uuid.dart';

import 'package:organizer/models/date_information_model.dart';

class Task {
  String id;
  DateInformation dateInformation;
  String name;
  String text;
  Task parentTask;
  List<Task> subTasks;
  bool _done = false;

  Task(this.name,
      {this.text = '',
      this.parentTask,
      String id,
      List<Task> subTasks,
      DateTime targetDate})
      : this.id = id ?? Uuid().generateV4(),
        this.subTasks = subTasks ?? [],
        this.dateInformation = DateInformation(targetDate: targetDate);

  Task.fromJson(Map<String, Object> json)
      : id = json["id"] as String,
        dateInformation = DateInformation.fromJson(json["date"]),
        name = json["name"] as String,
        text = json["text"] as String,
        _done = json["done"] as bool {
    if (json["parentTask"] != null) {
      parentTask = Task.fromJson(json["parentTask"]);
    }
    subTasks = [];
    if (json != null) {
      var tasksRest = json["subTasks"] as List;
      if (tasksRest != null) {
        subTasks = tasksRest.map<Task>((json) => Task.fromJson(json)).toList();
      }
    }
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "date": dateInformation,
      "name": name,
      "text": text,
      "parentTask": parentTask,
      "subTasks": subTasks,
      "done": _done,
    };
  }

  double donePercentage() {
    if (subTasks.length == 0) {
      return _done ? 100.0 : 0.0;
    }
    double donePercentage = 0.0;
    for (Task task in subTasks) {
      donePercentage += task.donePercentage();
    }
    return donePercentage / subTasks.length;
  }

  bool canBeMarkedAsDone() {
    return subTasks.length == 0;
  }

  bool get done => _done;
  set done(bool done) => this._done = canBeMarkedAsDone() ? done : this._done;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      text.hashCode ^
      parentTask.hashCode ^
      subTasks.hashCode ^
      _done.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          dateInformation == other.dateInformation &&
          name == other.name &&
          text == other.text &&
          parentTask == other.parentTask &&
          subTasks == other.subTasks &&
          _done == other._done;

  @override
  String toString() {
    return 'Task{id: $id, createdAt: date: $dateInformation, '
        'name: $name, text: $text, parentTask: $parentTask, '
        'subTasks: $subTasks, done: $_done}';
  }
}

typedef TaskAdder(Task task);
typedef TaskRemover(Task task);
typedef TaskUpdater(
  Task task, {
  String id,
  DateTime targetDate,
  String name,
  String text,
  Task parentTask,
  List<Task> subTasks,
  bool done,
});
