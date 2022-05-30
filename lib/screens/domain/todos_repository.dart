import 'package:flutter_theme/screens/domain/todos.dart';

abstract class TodosRepository {
  Future<Todos> addNewTodo(Todos todo);
  Future<Todos> deleteTodo(Todos todo);
  Future<Todos> updateTodo(Todos todo);
}
