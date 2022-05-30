import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_theme/screens/domain/todos_repository.dart';
import 'package:flutter_theme/screens/domain/todos.dart';

class FirebaseTodosRepository implements TodosRepository {
  final todoCollection = FirebaseFirestore.instance.collection('todos');

  @override
  Future<Todos> addNewTodo(Todos todo) async {
    var _todos = await todoCollection.add(todo.toEntity().toDocument());
    return _todos as Future<Todos>;
  }

  @override
  Future<Todos> deleteTodo(Todos todo) async {
    var _todos = await todoCollection.doc(todo.id).delete();
    return _todos as Future<Todos>;
  }

  @override
  Future<Todos> updateTodo(Todos update) async {
    var _todos = await todoCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
    return _todos as Future<Todos>;
  }
}
