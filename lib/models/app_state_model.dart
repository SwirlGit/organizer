import 'package:organizer/models/note_model.dart';

class AppState {
  bool isLoading;
  List<Note> notes;

  AppState({
    this.isLoading = false,
    notes,
  }) : this.notes = notes ?? [];

  factory AppState.loading() => AppState(isLoading: true);

  AppState.fromJson(Map<String, dynamic> json) : isLoading = false {
    if (json != null) {
      var rest = json["notes"] as List;
      notes = rest.map<Note>((json) => Note.fromJson(json)).toList();
    } else {
      notes = [];
    }
  }

  Map<String, dynamic> toJson() {
    if (isLoading) {
      return null;
    }
    return {
      "notes": notes,
    };
  }

  @override
  int get hashCode => notes.hashCode ^ isLoading.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          notes == other.notes &&
          isLoading == other.isLoading;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, notes: $notes}';
  }
}
