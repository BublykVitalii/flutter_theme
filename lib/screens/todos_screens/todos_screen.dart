import 'package:flutter/material.dart';
import 'package:flutter_theme/application.dart';
import 'package:flutter_theme/utils/localization_extensions.dart';
import 'package:provider/provider.dart';

class Todos extends StatefulWidget {
  static const _routeName = '/todo-list-screen';

  static PageRoute<Todos> get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return const Todos();
      },
    );
  }

  const Todos({Key? key}) : super(key: key);

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
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
                    child: TextFormField(
                      validator: _validate,
                      decoration: InputDecoration(
                        hintText: context.localizations!.enterTask,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: _onPressedSave,
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
  }

  void _onPressedSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.localizations!.error;
    }
    return null;
  }
}
