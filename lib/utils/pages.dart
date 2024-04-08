import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/add_task/add_task_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/task_detail/task_detail_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/initializer_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/splash_screen.dart';
import 'route_names.dart';

class Pages {
  static List<GetPage<dynamic>> pages = [
    GetPage(name: RouteName.initial.name, page: () => initial),
    GetPage(name: RouteName.splash.name, page: () => splash),
    GetPage(name: RouteName.login.name, page: () => login),
    GetPage(name: RouteName.register.name, page: () => register),
    GetPage(name: RouteName.home.name, page: () => home),
    GetPage(name: RouteName.addTask.name, page: () => addTask),
    GetPage(name: RouteName.detailTask.name, page: () => detailTask),
    GetPage(name: RouteName.profile.name, page: () => profile)
  ];
  static Widget get initial => InitializerScreen();
  static Widget get splash => const SplashScreen();
  static Widget get login => LoginScreen();
  static Widget get register => RegisterScreen();
  static Widget get home => HomeScreen();
  static Widget get profile => ProfileScreen();
  static Widget get addTask => AddTaskScreen();
  static Widget get detailTask => TaskDetailScreen();
}
