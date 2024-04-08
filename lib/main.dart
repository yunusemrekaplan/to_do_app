import 'dart:developer';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'utils/pages.dart';
import 'utils/route_names.dart';
import 'utils/theme.dart';

void main() async {
  await AppStart.init();
  //LocalStorage().delete(key: 'isFirstTime');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Master',
      theme: CustomTheme.themeData,
      getPages: Pages.pages,
      initialRoute: RouteName.initial.name,
    );
  }
}

class AppStart {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );

    String? token = await FirebaseAppCheck.instance.getToken();
    log(token!);
  }
}
