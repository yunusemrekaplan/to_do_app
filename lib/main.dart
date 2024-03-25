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
        GetPage(name: RouteNames.splash, page: () => Pages.splash),
        GetPage(name: RouteNames.login, page: () => Pages.login),
        GetPage(name: RouteNames.register, page: () => Pages.register),
        GetPage(name: RouteNames.home, page: () => Pages.home),
      ],
      initialRoute: RouteNames.splash,
    );
  }
}
