abstract class TodoRepository {
  Future addNewTodo(String note);
  Future deleteTodo(String id);
  Future updateTodo(String id);
  Future todoFromFirestore();
  Future changeTodo(String note, String id);
}
