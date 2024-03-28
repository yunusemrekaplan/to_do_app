import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/auth_result.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';
import '../../utils/route_names.dart';

class RegisterController extends GetxController {
  final _userService = UserService();

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _isLoading = false.obs;
  final _isPasswordVisible = true.obs;
  final _isConfirmPasswordVisible = true.obs;
  final _isAutoValidate = false.obs;

  bool get isPasswordVisible => _isPasswordVisible.value;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible.value;
  bool get isAutoValidate => _isAutoValidate.value;
  bool get isLoading => _isLoading.value;

  void togglePasswordVisibility() =>
      _isPasswordVisible.value = !_isPasswordVisible.value;

  void toggleConfirmPasswordVisibility() =>
      _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;

  void toggleAutoValidate() => _isAutoValidate.value = true;

  void setLoading(bool value) => _isLoading.value = value;

  Future<void> submit() async {
    setLoading(true);
    toggleAutoValidate();
    if (formKey.currentState!.validate()) {
      await registerUser();
    }
    setLoading(false);
  }

  Future<void> registerUser() async {
    UserModel user = UserModel(
      email: emailController.text,
      fullName: fullNameController.text,
      password: passwordController.text,
    );
    AuthResult result = await _userService.registerWithEmailAndPassword(user);
    handleRegistrationResult(result);
  }

  void handleRegistrationResult(AuthResult result) {
    if (result.code == '200') {
      Get.offAllNamed(RouteName.home.name);
    } else {
      showErrorSnackbar(result.errorMessage!);
    }
  }

  void showErrorSnackbar(String error) {
    Get.snackbar(
      'Error',
      error,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      duration: const Duration(milliseconds: 1400),
    );
  }
}
