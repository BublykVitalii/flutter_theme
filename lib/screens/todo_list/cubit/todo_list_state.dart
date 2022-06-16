part of 'todo_list.cubit.dart';

enum TodoListStatus {
  initial,
  loading,
  success,
  error,
}

class TodoListState extends Equatable {
  final TodoListStatus status;
  final String? errorMessage;
  final List<Todo>? listTitle;
  final Todo? title;

  const TodoListState({
    this.status = TodoListStatus.initial,
    this.errorMessage,
    this.listTitle,
    this.title,
  });

  TodoListState copyWith({
    TodoListStatus? status,
    String? errorMessage,
    List<Todo>? listTitle,
    Todo? title,
  }) {
    return TodoListState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      listTitle: listTitle ?? this.listTitle,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        listTitle,
        title,
      ];
}
