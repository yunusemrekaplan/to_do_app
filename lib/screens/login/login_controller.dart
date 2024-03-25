import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/auth_result.dart';
import '../../services/user_service.dart';
import '../../utils/route_names.dart';

class LoginController extends GetxController {
  final _userService = UserService();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _isLoading = false.obs;
  final _isPasswordVisible = true.obs;
  final _isAutoValidate = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isPasswordVisible => _isPasswordVisible.value;
  bool get isAutoValidate => _isAutoValidate.value;

  void togglePasswordVisibility() =>
      _isPasswordVisible.value = !_isPasswordVisible.value;

  void toggleAutoValidate() => _isAutoValidate.value = true;

  void setLoading(bool value) => _isLoading.value = value;

  Future<void> submit() async {
    setLoading(true);
    toggleAutoValidate();
    if (formKey.currentState!.validate()) {
      await loginUser();
    }
    setLoading(false);
  }

  Future<void> loginUser() async {
    AuthResult result = await _userService.signInWithEmailAndPassword(
      emailController.text,
      passwordController.text,
    );
    handleLoginResult(result);
  }

  void handleLoginResult(AuthResult result) {
    if (result.code == '200') {
      Get.offNamed(RouteNames.home);
    } else {
      showErrorSnackbar(result.errorMessage!);
    }
  }

  void showErrorSnackbar(String errorMessage) {
    Get.snackbar(
      'Error',
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      duration: const Duration(milliseconds: 1400),
    );
  }
}
