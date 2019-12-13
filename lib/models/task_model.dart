import 'package:organizer/common/uuid.dart';

import 'package:organizer/models/date_information_model.dart';

class Task {
  String id;
  DateInformation dateInformation;
  String name;
  String text;
  bool done;

  Task(this.name,
      {this.text = '', this.done = false, String id, DateTime targetDate})
      : this.id = id ?? Uuid().generateV4(),
        this.dateInformation = DateInformation(targetDate: targetDate);

  Task.fromJson(Map<String, Object> json)
      : id = json["id"] as String,
        dateInformation = DateInformation.fromJson(json["date"]),
        name = json["name"] as String,
        text = json["text"] as String,
        done = json["done"] as bool;

  Map<String, Object> toJson() {
    return {
      "id": id,
      "date": dateInformation,
      "name": name,
      "text": text,
      "done": done,
    };
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ text.hashCode ^ done.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          dateInformation == other.dateInformation &&
          name == other.name &&
          text == other.text &&
          done == other.done;

  @override
  String toString() {
    return 'Task{id: $id, createdAt: date: $dateInformation, '
        'name: $name, text: $text, done: $done}';
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
  bool done,
});
