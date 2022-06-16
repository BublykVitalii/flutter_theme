import 'package:flutter_theme/screens/domain/todo.dart';

abstract class UserRepository {
  Future<Todo?> getMainTodo(String userId);
  Future<List<Todo>> getTodo(String userId);
  Future<void> createNewTodo(Todo todo, String userId);
  Future<void> editTodo(Todo todo, String userId);
  Future<void> removeTodo(String id, String userId);
}
