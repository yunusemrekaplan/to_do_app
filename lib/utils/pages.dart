import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/splash_screen.dart';

class Pages {
  static Widget get splash => const SplashScreen();
  static Widget get home => const HomeScreen();
  static Widget get login => LoginScreen();
  static Widget get register => RegisterScreen();
}
