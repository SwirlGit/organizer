import 'package:organizer/models/note_model.dart';

class AppState {
  bool isLoading;
  List<Note> notes;

  AppState({
    this.isLoading = false,
    this.notes = const [],
  });

  factory AppState.loading() => AppState(isLoading: true);

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
    return 'AppState{isLoading: $isLoading, todos: $notes}';
  }
}
