import 'package:get/get.dart';

import '../../services/user_service.dart';
import '../../utils/route_names.dart';

class ProfileController extends GetxController {
  final _userService = UserService();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  Future<void> signOut() async {
    await _userService.signOut();

    Get.offAllNamed(RouteName.initial.name);
  }
}
