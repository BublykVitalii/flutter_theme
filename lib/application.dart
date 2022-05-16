import 'package:flutter/material.dart';
import 'package:flutter_theme/infrastructure/app_images.dart';
import 'package:flutter_theme/infrastructure/theme/app_colors.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return const NeumorphicDesign();
  }
}

class NeumorphicDesign extends StatelessWidget {
  const NeumorphicDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Theme'),
          backgroundColor: AppColors.background,
        ),
        body: Center(
          child: Container(
            height: 300,
            width: 300,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(1, 1),
                  blurRadius: 0.1,
                  spreadRadius: 0.1,
                ),
              ],
            ),
            child: Image.asset(AppImages.logo),
          ),
        ),
      ),
    );
  }
}
