import 'package:flutter_theme/screens/domain/todos.dart';
import 'package:flutter_theme/screens/domain/todos_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class TodosService {
  TodosService(this._todoRepository);

  final TodosRepository _todoRepository;

  Todos? _todo;
  Todos? get todo => _todo;

  Future<Todos?> addNewTodo(Todos todo) async {
    _todo = await _todoRepository.addNewTodo(todo);
    return _todo;
  }

  Future<Todos?> deleteTodo(Todos todo) async {
    _todo = await _todoRepository.deleteTodo(todo);
    return _todo;
  }

  Future<Todos?> updateTodo(Todos todo) async {
    _todo = await _todoRepository.updateTodo(todo);
    return _todo;
  }
}
