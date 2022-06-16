import 'package:flutter_theme/screens/domain/todo.dart';
import 'package:flutter_theme/user/domain/user_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserService {
  UserService(this._userRepository);

  final UserRepository _userRepository;

  Todo? _todo;
  Todo? get todo => _todo;

  Future<Todo?> getMainTodo(String userId) async {
    _todo = await _userRepository.getMainTodo(userId);
    return _todo;
  }

  Future<List<Todo>> getTodo(String userId) async {
    return await _userRepository.getTodo(userId);
  }

  Future<void> createNewTodo(Todo todo, String userId) async {
    return await _userRepository.createNewTodo(todo, userId);
  }

  Future<void> editTodo(Todo todo, String userId) async {
    return await _userRepository.editTodo(todo, userId);
  }

  Future<void> removeTodo(String id, String userId) async {
    return await _userRepository.removeTodo(id, userId);
  }
}
