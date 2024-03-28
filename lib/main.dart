import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'utils/pages.dart';
import 'utils/route_names.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Master',
      theme: CustomTheme.themeData,
      getPages: [
        GetPage(name: RouteName.initial.name, page: () => Pages.initial),
        GetPage(name: RouteName.splash.name, page: () => Pages.splash),
        GetPage(name: RouteName.login.name, page: () => Pages.login),
        GetPage(name: RouteName.register.name, page: () => Pages.register),
        GetPage(name: RouteName.home.name, page: () => Pages.home),
        GetPage(name: RouteName.addTask.name, page: () => Pages.addTask),
      ],
      initialRoute: RouteName.initial.name,
    );
  }
}
