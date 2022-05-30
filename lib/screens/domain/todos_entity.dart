import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodosEntity extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;

  const TodosEntity(this.task, this.id, this.note, this.complete);

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'task': task,
      'note': note,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'TodosEntity { complete: $complete, task: $task, note: $note, id: $id ,}';
  }

  static TodosEntity fromJson(Map<String, Object> json) {
    return TodosEntity(
      json['task'] as String,
      json['id'] as String,
      json['note'] as String,
      json['complete'] as bool,
    );
  }

  // static TodosEntity fromSnapshot(DocumentSnapshot snap) {
  //   return TodosEntity(
  //     snap.data()['task'],
  //     snap.id,
  //     snap.data['note'],
  //     snap.data['complete'],
  //   );
  // }

  // static TodosEntity fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
  //   return TodosEntity(
  //     doc.id,
  //     doc.data()!['task'],
  //     doc.data()!['note'],
  //     doc.data()!['complete'],
  //   );
  // }

  static TodosEntity fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodosEntity(
      doc.id,
      doc.data()!['task'],
      doc.data()!['note'],
      doc.data()!['complete'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'complete': complete,
      'task': task,
      'note': note,
    };
  }

  @override
  List<Object?> get props => [
        complete,
        id,
        note,
        task,
      ];
}
