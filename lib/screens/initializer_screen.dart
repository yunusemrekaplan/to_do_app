import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/local_storage.dart';
import 'package:todo_app/services/user_service.dart';
import 'package:todo_app/utils/route_names.dart';

// ignore: must_be_immutable
class InitializerScreen extends StatelessWidget {
  InitializerScreen({super.key});
  final _localStorage = LocalStorage();
  final _userService = UserService();

  RouteName routeName = RouteName.splash;

  Future<void> initialize() async {
    String? isFirstTime = await _localStorage.read(key: 'isFirstTime');
    if (isFirstTime == null) {
      log('InitializerScreen.initialize: isFirstTime is null');
      routeName = RouteName.splash;
      await _localStorage.write(key: 'isFirstTime', value: 'false');
    } else {
      log('InitializerScreen.initialize: isFirstTime is not null');
      String? userUid = await _localStorage.read(key: 'userUid');

      if (userUid == null) {
        log('InitializerScreen.initialize: userId is null');
        routeName = RouteName.login;
      } else {
        log('InitializerScreen.initialize: userId is not null');
        try {
          await _userService.getUserByIdAndSetAsCurrentUser(userUid);
          log('InitializerScreen.initialize: user found');
          routeName = RouteName.home;
        } on Exception catch (e) {
          log('InitializerScreen.initialize: $e');
          routeName = RouteName.login;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: initialize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              log('InitializerScreen.build: routeName: $routeName');
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.offAllNamed(routeName.name);
              });
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
