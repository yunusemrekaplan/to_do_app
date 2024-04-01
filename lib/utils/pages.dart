import 'package:flutter/material.dart';

import '../screens/add_task/add_task_screen.dart';
import '../screens/task_detail/task_detail_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/initializer_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/splash_screen.dart';

class Pages {
  static Widget get initial => InitializerScreen();
  static Widget get splash => const SplashScreen();
  static Widget get home => HomeScreen();
  static Widget get login => LoginScreen();
  static Widget get register => RegisterScreen();
  static Widget get addTask => AddTaskScreen();
  static Widget get detailTask => TaskDetailScreen();
}
