import 'package:get/get.dart';

import 'route_names.dart';

class CustomNavigator {
  static goToRegisterScreen() {
    Get.offAllNamed(RouteName.register.name);
  }

  static goToLogInScreen() {
    Get.offAllNamed(RouteName.login.name);
  }

  static goToHomeScreen() {
    Get.offNamed(RouteName.home.name);
  }
}
