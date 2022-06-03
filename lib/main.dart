import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme/application.dart';
import 'package:flutter_theme/infrastructure/injectable.init.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final getIt = GetIt.instance;
  await configureDependencies(getIt);

  runApp(const MyApp());
}
