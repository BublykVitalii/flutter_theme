import 'package:flutter_theme/screens/domain/todos_entity.dart';
import 'package:meta/meta.dart';

@immutable
class Todos {
  final bool complete;
  final String id;
  final String note;
  final String task;

  const Todos(
    this.task,
    this.id, {
    this.complete = false,
    this.note = '',
  });

  Todos copyWith({
    bool? complete,
    String? id,
    String? note,
    String? task,
  }) {
    return Todos(
      task ?? this.task,
      id ?? this.id,
      complete: complete ?? this.complete,
      note: note ?? this.note,
    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todos &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id;

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
  }

  TodosEntity toEntity() {
    return TodosEntity(task, id, note, complete);
  }

  static Todos fromEntity(TodosEntity entity) {
    return Todos(
      entity.task,
      entity.id,
      complete: entity.complete,
      note: entity.note,
    );
  }

  List<Object?> get props => [
        complete,
        id,
        note,
        task,
      ];
}
