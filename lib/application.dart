import 'package:flutter/material.dart';
import 'package:flutter_theme/infrastructure/theme/app_colors.dart';
import 'package:flutter_theme/infrastructure/theme/theme_extensions.dart';
import 'package:flutter_theme/ui_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: context.theme.colorScheme.copyWith(
        primary: AppColors.black,
      ),
    );

    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      theme: theme,
    );
  }

  Route onGenerateRoute(RouteSettings? settings) {
    return UiScreen.route;
  }
}
