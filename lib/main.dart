import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/app/app.dart';
import 'package:gb_lottery_b2b/src/app/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppTheme.init();
  // await setupLocator();

  runApp(const App());
}
