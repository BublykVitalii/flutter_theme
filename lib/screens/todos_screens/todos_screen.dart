import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_theme/application.dart';
import 'package:flutter_theme/screens/domain/todos.dart';
import 'package:flutter_theme/screens/todos_screens/cubit/todos_cubit.dart';
import 'package:flutter_theme/utils/localization_extensions.dart';

class TodosScreen extends StatefulWidget {
  static const _routeName = '/todo-list-screen';

  static PageRoute<TodosScreen> get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return BlocProvider(
          create: (context) => TodosCubit(),
          child: const TodosScreen(),
        );
      },
    );
  }

  const TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  TodosCubit get todosCubit => BlocProvider.of<TodosCubit>(context);
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  String? task;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InputTask(
                          onSaved: (value) {
                            task = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        onPressed: () {
                          print(task);
                        },
                        child: const Icon(Icons.save),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _onPressedSave;
                                isChecked = value!;
                              });
                            },
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
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
                          title: Text('item $index'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onPressedSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //todosCubit.addTask(task);
    }
  }
}

class InputTask extends StatelessWidget {
  const InputTask({
    Key? key,
    required this.onSaved,
    this.task,
  }) : super(key: key);
  final ValueChanged<String?> onSaved;
  final String? task;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: _validate,
      decoration: InputDecoration(
        hintText: context.localizations!.enterTask,
      ),
    );
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'something error';
    }
    return null;
  }
}
