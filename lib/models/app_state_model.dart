import 'package:organizer/models/note_model.dart';
import 'package:organizer/models/task_model.dart';

class AppState {
  bool isLoading;
  List<Task> tasks;
  List<Note> notes;

  AppState({
    this.isLoading = false,
    tasks,
    notes,
  })  : this.tasks = tasks ?? [],
        this.notes = notes ?? [];

  factory AppState.loading() => AppState(isLoading: true);

  AppState.fromJson(Map<String, dynamic> json) : isLoading = false {
    tasks = [];
    notes = [];
    if (json != null) {
      var tasksRest = json["tasks"] as List;
      if (tasksRest != null) {
        tasks = tasksRest.map<Task>((json) => Task.fromJson(json)).toList();
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
      "tasks": tasks,
      "notes": notes,
    };
  }

  List<Task> possibleParentTasksFor(Task task) {
    List<Task> possibleParents = [];
    for (int i = 0; i < tasks.length; ++i) {
      if (tasks[i].canBeParentTaskTo(task)) {
        possibleParents.add(tasks[i]);
      }
    }
    return possibleParents;
  }

  List<Task> possibleSubTasksFor(Task task) {
    List<Task> possibleSubs = [];
    for (int i = 0; i < tasks.length; ++i) {
      if (tasks[i].canBeSubTaskTo(task)) {
        possibleSubs.add(tasks[i]);
      }
    }
    return possibleSubs;
  }

  @override
  int get hashCode => tasks.hashCode ^ notes.hashCode ^ isLoading.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          tasks == other.tasks &&
          notes == other.notes &&
          isLoading == other.isLoading;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, tasks: $tasks, notes: $notes}';
  }
}
