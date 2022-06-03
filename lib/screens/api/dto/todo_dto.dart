import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_theme/screens/domain/todo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_dto.g.dart';

@JsonSerializable()
class TodoDTO {
  final bool complete;
  final String id;
  final String note;
  final String title;
  final List<TodoDTO> todos;
  const TodoDTO(
    this.title,
    this.id,
    this.note,
    this.complete,
    this.todos,
  );

  Todo toTodo() {
    return Todo(
      title,
      id,
      note: note,
      complete: complete,
    );
  }

  static Todo fromTodo(Todo todo) {
    return Todo(
      todo.title,
      todo.id,
      complete: todo.complete,
      note: todo.note,
    );
  }

  Map<String, dynamic> toJson() => _$TodoDTOToJson(this);

  factory TodoDTO.fromJson(Map<String, dynamic> json) =>
      _$TodoDTOFromJson(json);

  List<Todo> toTodos() {
    return todos.map((todo) => todo.toTodo()).toList();
  }

  static TodoDTO fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoDTO(
      doc.id,
      doc.data()!['title'],
      doc.data()!['note'],
      doc.data()!['complete'],
      doc.data()!['todos'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'complete': complete,
      'title': title,
      'note': note,
    };
  }
}
