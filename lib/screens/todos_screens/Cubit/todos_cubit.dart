import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_theme/screens/domain/todos.dart';
import 'package:flutter_theme/screens/domain/todos_service.dart';
import 'package:get_it/get_it.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit() : super(const TodosState());
  TodosService get todosService => GetIt.instance.get<TodosService>();

  void addTask(Todos todos) async {
    emit(state.copyWith(status: TodosStatus.loading));
    await todosService.addNewTodo(todos);
  }
}
