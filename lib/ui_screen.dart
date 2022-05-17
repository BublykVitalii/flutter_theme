import 'package:flutter/material.dart';

import 'package:flutter_theme/infrastructure/theme/app_colors.dart';
import 'package:flutter_theme/infrastructure/theme/theme_extensions.dart';

enum Menu {
  itemOne,
  itemTwo,
  itemThree,
}

enum SingingCharacter { hardy, jefferson }

class UiScreen extends StatefulWidget {
  static const _routeName = '/ui-screen';

  static PageRoute<UiScreen> get route {
    return MaterialPageRoute(
      settings: const RouteSettings(name: _routeName),
      builder: (context) {
        return const UiScreen();
      },
    );
  }

  const UiScreen({Key? key}) : super(key: key);

  @override
  State<UiScreen> createState() => _UiScreen();
}

SingingCharacter? _character = SingingCharacter.hardy;
double _currentSliderValue = 20;
bool isPasswordVisible = false;

class _UiScreen extends State<UiScreen> {
  String? user;
  String? password;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.black,
        drawer: const _DrawerMenu(),
        appBar: AppBar(
          actions: const <Widget>[
            PopUpMenu(),
          ],
          centerTitle: true,
          title: const Text('Flutter Theme'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextHeadline(),
                  const Line(),
                  const Buttons(),
                  const Line(),
                  const Switchers(),
                  const Line(),
                  const Checkboxs(),
                  const Line(),
                  const SizedBox(height: 40),
                  InputUser(
                    onSaved: (value) {
                      user = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  InputPassword(
                    isVisible: isPasswordVisible,
                    onShow: (value) {
                      setState(() {
                        isPasswordVisible = !value;
                      });
                    },
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(height: 40),
                  FloatingActionButton(
                    splashColor: Colors.white,
                    onPressed: _checkValidate,
                    backgroundColor: AppColors.green,
                    child: const Icon(
                      Icons.add,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _checkValidate() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}

class _DrawerMenu extends StatelessWidget {
  const _DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.black,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.message,
              color: AppColors.black,
            ),
            title: Text(
              'Messages',
              style: TextStyle(
                color: AppColors.black,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: AppColors.black,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: AppColors.black,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: AppColors.black,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      color: AppColors.black,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        const PopupMenuItem<Menu>(
          value: Menu.itemOne,
          child: Text(
            'Item 1',
            style: TextStyle(color: AppColors.green),
          ),
        ),
        const PopupMenuItem<Menu>(
          value: Menu.itemTwo,
          child: Text(
            'Item 2',
            style: TextStyle(color: AppColors.green),
          ),
        ),
        const PopupMenuItem<Menu>(
          value: Menu.itemThree,
          child: Text(
            'Item 3',
            style: TextStyle(color: AppColors.green),
          ),
        ),
      ],
    );
  }
}

class TextHeadline extends StatelessWidget {
  const TextHeadline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'headline1',
          style: textTheme.headline1!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'headline2',
          style: textTheme.headline2!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'headline3',
          style: textTheme.headline3!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'headline4',
          style: textTheme.headline4!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'headline5',
          style: textTheme.headline5!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'headline6',
          style: textTheme.headline6!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'subtitle1',
          style: textTheme.subtitle1!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'subtitle2',
          style: textTheme.subtitle2!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'bodyText1',
          style: textTheme.bodyText1!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'bodyText2',
          style: textTheme.bodyText2!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'button',
          style: textTheme.button!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'caption',
          style: context.theme.textTheme.caption!.copyWith(color: Colors.white),
        ),
        const Line(),
        Text(
          'overline',
          style:
              context.theme.textTheme.overline!.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}

class Buttons extends StatefulWidget {
  const Buttons({
    Key? key,
  }) : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<String>(
          dropdownColor: AppColors.black,
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: AppColors.green),
          underline: Container(
            height: 2,
            color: Colors.white,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>[
            'One',
            'Two',
            'Free',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor: MaterialStateProperty.all(AppColors.green),
              ),
              onPressed: () {},
              child: const Text(
                'Enabled',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: null,
              child: const Text(
                'Disable',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            FloatingActionButton(
              splashColor: AppColors.green,
              onPressed: () {},
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: AppColors.black,
              ),
            ),
            const SizedBox(width: 10),
            const FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            IconButton(
              color: Colors.white,
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                color: AppColors.green,
              ),
            ),
            const SizedBox(width: 10),
            const IconButton(
              disabledColor: Colors.grey,
              onPressed: null,
              icon: Icon(
                Icons.favorite,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor: MaterialStateProperty.all(AppColors.green),
              ),
              onPressed: () {},
              child: const Text(
                'Click Me',
                style: TextStyle(
                  color: AppColors.black,
                ),
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: null,
              child: const Text(
                'Click Me',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor: MaterialStateProperty.all(AppColors.green),
              ),
              onPressed: () {},
              child: const Text(
                'Enable',
                style: TextStyle(color: AppColors.black),
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: null,
              child: const Text(
                'Disable',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Switchers extends StatefulWidget {
  const Switchers({
    Key? key,
  }) : super(key: key);

  @override
  State<Switchers> createState() => _SwitchersState();
}

class _SwitchersState extends State<Switchers> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Colors.white,
      activeTrackColor: Colors.white,
      inactiveThumbColor: AppColors.green,
      inactiveTrackColor: AppColors.green,
      value: isSwitched,
      onChanged: (bool value) {
        setState(
          () {
            isSwitched = value;
          },
        );
      },
    );
  }
}

class Checkboxs extends StatefulWidget {
  const Checkboxs({Key? key}) : super(key: key);

  @override
  State<Checkboxs> createState() => _CheckboxsState();
}

class _CheckboxsState extends State<Checkboxs> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return AppColors.green;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          checkColor: Colors.black,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        ListTile(
          textColor: Colors.white,
          title: const Text('Tom Hardy'),
          leading: Radio<SingingCharacter>(
            activeColor: AppColors.green,
            value: SingingCharacter.hardy,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(
                () {
                  _character = value;
                },
              );
            },
          ),
        ),
        ListTile(
          textColor: Colors.white,
          title: const Text('Thomas Jefferson'),
          leading: Radio<SingingCharacter>(
            activeColor: AppColors.green,
            value: SingingCharacter.jefferson,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(
                () {
                  _character = value;
                },
              );
            },
          ),
        ),
        Slider(
          activeColor: AppColors.green,
          inactiveColor: Colors.white,
          thumbColor: AppColors.green,
          value: _currentSliderValue,
          max: 100,
          divisions: 5,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(
              () {
                _currentSliderValue = value;
              },
            );
          },
        ),
      ],
    );
  }
}

class InputUser extends StatelessWidget {
  const InputUser({
    Key? key,
    required this.onSaved,
  }) : super(key: key);
  final ValueChanged<String?> onSaved;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: TextFormField(
        validator: _validate,
        onSaved: onSaved,
        autofocus: false,
        style:
            context.theme.textTheme.subtitle1!.copyWith(color: AppColors.black),
        decoration: _ExtendedInputDecoration('user name'),
      ),
    );
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'invalid user';
    }
    return null;
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({
    Key? key,
    required this.onSaved,
    required this.isVisible,
    required this.onShow,
  }) : super(key: key);
  final ValueChanged<String?> onSaved;
  final bool isVisible;
  final ValueChanged<bool> onShow;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: TextFormField(
        obscureText: !isVisible,
        validator: _validate,
        onSaved: onSaved,
        autofocus: false,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.black,
            ),
            onPressed: () {
              onShow(isVisible);
            },
          ),
          filled: true,
          fillColor: AppColors.green,
          hintText: 'password',
          contentPadding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'invalid password';
    }
    return null;
  }
}

class _ExtendedInputDecoration extends InputDecoration {
  final String text;
  _ExtendedInputDecoration(
    this.text,
  ) : super(
          filled: true,
          fillColor: AppColors.green,
          hintText: text,
          contentPadding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
        );
}

class Line extends StatelessWidget {
  const Line({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.green,
    );
  }
}
