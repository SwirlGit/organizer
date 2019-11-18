import 'package:organizer/common/uuid.dart';

class Note {
  String id;
  String name;
  String text;

  Note(this.name, {this.text = '', String id})
      : this.id = id ?? Uuid().generateV4();

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ text.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          text == other.text;

  @override
  String toString() {
    return 'Todo{id: $id, name: $name, text: $text}';
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name,
      "text": text,
    };
  }

  static Note fromJson(Map<String, Object> json) {
    return Note(
      json["name"] as String,
      text: json["text"] as String,
      id: json["id"] as String,
    );
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
