import 'package:organizer/common/uuid.dart';

import 'package:organizer/models/date_information_model.dart';

class Note {
  String id;
  DateInformation dateInformation;
  String name;
  String text;

  Note(this.name, {this.text = '', String id})
      : this.id = id ?? Uuid().generateV4() {
    dateInformation.createdAt = DateTime.now().toUtc();
  }

  Note.fromJson(Map<String, Object> json)
      : id = json["id"] as String,
        name = json["name"] as String,
        text = json["text"] as String {
    dateInformation.createdAt = json["createdAt"] as DateTime;
    dateInformation.targetDate = json["targetDate"] as DateTime;
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "createdAt": dateInformation.createdAt,
      "targetDate": dateInformation.targetDate,
      "name": name,
      "text": text,
    };
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ text.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          dateInformation.createdAt == other.dateInformation.createdAt &&
          dateInformation.targetDate == other.dateInformation.targetDate &&
          name == other.name &&
          text == other.text;

  @override
  String toString() {
    return 'Note{id: $id, createdAt: ${dateInformation.createdAt}, '
        'targetDate: ${dateInformation.targetDate}, '
        'name: $name, text: $text}';
  }
}

typedef NoteAdder(Note note);
typedef NoteRemover(Note note);
typedef NoteUpdater(
  Note note, {
  String id,
  String name,
  String text,
});
