import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_theme/screens/domain/todo.dart';
import 'package:flutter_theme/screens/domain/todo_exceptions.dart';
import 'package:flutter_theme/user/domain/user_service.dart';
import 'package:get_it/get_it.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(const TodoListState());

  UserService get userService => GetIt.instance.get<UserService>();

  void getMainTodo(String id) async {
    try {
      emit(state.copyWith(status: TodoListStatus.loading));
      final title = await userService.getMainTodo(id);
      emit(state.copyWith(
        status: TodoListStatus.success,
        title: title,
      ));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: TodoListStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void createNewTodo(Todo todo, String userId) async {
    try {
      emit(state.copyWith(status: TodoListStatus.loading));
      await userService.createNewTodo(todo, userId);
      emit(state.copyWith(status: TodoListStatus.success));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: TodoListStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void removeTodo(String id, String userId) async {
    try {
      emit(state.copyWith(status: TodoListStatus.loading));
      await userService.removeTodo(id, userId);
      final title = await userService.getMainTodo(userId);
      emit(state.copyWith(
        status: TodoListStatus.success,
        title: title,
      ));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: TodoListStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void editTodo(Todo todo, String userId) async {
    try {
      emit(state.copyWith(status: TodoListStatus.loading));
      await userService.editTodo(todo, userId);
      final list = await userService.getMainTodo(userId);
      emit(state.copyWith(
        status: TodoListStatus.success,
        title: list,
      ));
    } on TodoExceptions catch (error) {
      emit(state.copyWith(
        status: TodoListStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
