class TodoAlreadyExistException implements Exception {
  final String todoInfo;
  TodoAlreadyExistException(this.todoInfo);

  @override
  String toString() {
    return 'The todo is already exist : $todoInfo';
  }
}

class TodoNotExistException implements Exception {
  final String todoInfo;
  TodoNotExistException(this.todoInfo);

  @override
  String toString() {
    return 'The todo is not exist : $todoInfo';
  }
}
