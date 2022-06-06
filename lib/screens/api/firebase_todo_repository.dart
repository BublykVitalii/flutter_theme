import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_theme/screens/domain/todo.dart';
import 'package:flutter_theme/screens/domain/todo_exceptions.dart';
import 'package:flutter_theme/screens/domain/todo_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: TodoRepository)
class FirebaseTodoRepository implements TodoRepository {
  final todoCollection = FirebaseFirestore.instance.collection('privet');

  @override
  Future addNewTodo(String note) async {
    try {
      await todoCollection.add({
        "note": note,
        "complete": false,
      });
    } on DioError catch (error) {
      if (error.response == null) {
        throw const TodoExceptions();
      }
      rethrow;
    }
  }

  @override
  Future deleteTodo(String id) async {
    try {
      await todoCollection.doc(id).delete();
    } on DioError catch (error) {
      if (error.response == null) {
        throw const TodoExceptions();
      }
      rethrow;
    }
  }

  @override
  Future changeTodo(String note, String id) async {
    try {
      await todoCollection.doc(id).update({'note': note});
    } on DioError catch (error) {
      if (error.response == null) {
        throw const TodoExceptions();
      }
      rethrow;
    }
  }

  @override
  Future updateTodo(String id) async {
    await todoCollection.doc(id).update({"complete": true});
  }

  @override
  Future<List<Todo>> todoFromFirestore() async {
    try {
      final todos = await todoCollection.get().then((snapshot) {
        return snapshot.docs.map((e) {
          return Todo(
            e.data()["title"] ?? e.data()['note'],
            e.id,
            complete: e.data()["complete"],
            note: e.data()['note'],
          );
        }).toList();
      });
      return todos;
    } on DioError catch (error) {
      if (error.response == null) {
        throw const TodoExceptions();
      }
      rethrow;
    }
  }
}
