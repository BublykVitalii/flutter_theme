part of 'todos_cubit.dart';

enum TodosStatus {
  initial,
  loading,
  success,
  error,
}

class TodosState extends Equatable {
  final TodosStatus status;
  final String? errorMessage;
  final List<Todos>? taskList;
  final Todos? task;

  const TodosState({
    this.status = TodosStatus.initial,
    this.errorMessage,
    this.taskList,
    this.task,
  });

  TodosState copyWith({
    TodosStatus? status,
    String? errorMessage,
    List<Todos>? taskList,
    Todos? task,
  }) {
    return TodosState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      taskList: taskList ?? this.taskList,
      task: task ?? this.task,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        taskList,
        task,
      ];
}
