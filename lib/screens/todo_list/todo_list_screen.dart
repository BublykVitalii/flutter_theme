import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_theme/application.dart';
import 'package:flutter_theme/auth/domain/auth_service.dart';
import 'package:flutter_theme/auth/screen/auth_screen.dart';
import 'package:flutter_theme/screens/domain/todo.dart';
import 'package:flutter_theme/screens/todo_list/cubit/todo_list.cubit.dart';
import 'package:flutter_theme/utils/localization_extensions.dart';
import 'package:get_it/get_it.dart';

class TodoList extends StatefulWidget {
  static const _routeName = '/todo-list-screen';

  static PageRoute<TodoList> get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return BlocProvider(
          create: (context) => TodoListCubit(),
          child: const TodoList(),
        );
      },
    );
  }

  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  AuthService get authService => GetIt.instance.get<AuthService>();
  TodoListCubit get todoListCubit => BlocProvider.of<TodoListCubit>(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListCubit, TodoListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.localizations!.todoList),
            actions: [
              PopupMenuButton<ThemeMode>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: ThemeMode.light,
                    child: Text(context.localizations!.lightMode),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.dark,
                    child: Text(context.localizations!.darkMode),
                  ),
                ],
                onSelected: (themeMode) {
                  context.read<MyAppState>().setThemeMode(themeMode);
                },
              ),
            ],
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8.0),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: state.listTitle?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    List<Todo> todo = state.listTitle ?? [];
                    return const TodoCard();
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => CreateTodo(
                          onPressed: (noteChanged) {
                            //todoListCubit.createNewTodo(todo, '');
                          },
                          titleTodo: '',
                        ),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      authService.logOut();
                      Navigator.pushReplacement(context, AuthScreen.route);
                    },
                    child: const Icon(Icons.logout_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        title: const Text('todo'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                // showDialog<String>(
                //   context: context,
                //   builder: (BuildContext context) => ChangeTodo(
                //     onPressed: (noteChanged) {
                //       todoCubit.changeNote(
                //         noteChanged,
                //         todo[index].id,
                //       );
                //     },
                //     noteChanged: todo[index].note,
                //   ),
                // );
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CreateTodo extends StatelessWidget {
  CreateTodo({
    Key? key,
    required this.onPressed,
    required this.titleTodo,
  }) : super(key: key);
  final ValueChanged<String> onPressed;
  String titleTodo;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(context.localizations!.addTodo),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: titleTodo,
            onChanged: (text) {
              titleTodo = text;
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(context.localizations!.cancel),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(context.localizations!.change),
          onPressed: () {
            onPressed(titleTodo);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
