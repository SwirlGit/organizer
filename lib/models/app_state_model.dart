import 'package:organizer/models/note_model.dart';
import 'package:organizer/models/todo_model.dart';

class AppState {
  bool isLoading;
  List<Todo> todos;
  List<Note> notes;

  AppState({
    this.isLoading = false,
    todos,
    notes,
  })  : this.todos = todos ?? [],
        this.notes = notes ?? [];

  factory AppState.loading() => AppState(isLoading: true);

  AppState.fromJson(Map<String, dynamic> json) : isLoading = false {
    todos = [];
    notes = [];
    if (json != null) {
      var todosRest = json["todos"] as List;
      if (todosRest != null) {
        todos = todosRest.map<Todo>((json) => Todo.fromJson(json)).toList();
      }
      var notesRest = json["notes"] as List;
      if (notesRest != null) {
        notes = notesRest.map<Note>((json) => Note.fromJson(json)).toList();
      }
    }
  }

  Map<String, dynamic> toJson() {
    if (isLoading) {
      return null;
    }
    return {
      "todos": todos,
      "notes": notes,
    };
  }

  @override
  int get hashCode => todos.hashCode ^ notes.hashCode ^ isLoading.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          todos == other.todos &&
          notes == other.notes &&
          isLoading == other.isLoading;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, todos: $todos, notes: $notes}';
  }
}
