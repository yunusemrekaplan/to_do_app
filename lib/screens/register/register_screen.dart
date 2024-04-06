import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/double.dart';
import '../../utils/constants/padding.dart';
import '../../utils/constants/string.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/validator.dart';
import '../../widgets/divider.dart';
import '../../widgets/text_form_field.dart';
import 'register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: _registerController,
      builder: (controller) {
        return _buildScaffold(controller);
      },
    );
  }

  Scaffold _buildScaffold(RegisterController controller) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.appName)),
      body: _buildBody(controller),
    );
  }

  Padding _buildBody(RegisterController controller) {
    return Padding(
      padding: PaddingConstants.all16,
      child: SingleChildScrollView(
        child: SizedBox(
          height: DoubleConstants.calculateAvailableScreenHeight,
          child: Column(
            children: [
              _buildForm(controller),
              const SizedBox(height: 16),
              _buildButtons(controller),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildForm(RegisterController controller) {
    return Expanded(
      child: Obx(
        () => Form(
          key: controller.formKey,
          autovalidateMode: controller.autovalidateMode,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  StringConstants.signup,
                  style: TextStyleConstants.titleMediumBold,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: controller.fullNameController,
                  hintText: StringConstants.fullNameHintText,
                  validator: CustomValidator().validateFullName,
                ),
                CustomTextFormField(
                  controller: controller.emailController,
                  hintText: StringConstants.emailHintText,
                  validator: CustomValidator().validateEmail,
                ),
                Obx(
                  () => CustomTextFormField(
                    controller: controller.passwordController,
                    hintText: StringConstants.passwordHintText,
                    validator: CustomValidator().validatePassword,
                    isObscureText: true,
                    toggleVisibility: controller.togglePasswordVisibility,
                    isVisible: controller.isPasswordVisible,
                  ),
                ),
                Obx(
                  () => CustomTextFormField(
                    controller: controller.confirmPasswordController,
                    confirmPasswordController: controller.passwordController,
                    hintText: StringConstants.confirmPasswordHintText,
                    validator: CustomValidator().validateConfirmPassword,
                    isObscureText: true,
                    toggleVisibility:
                        controller.toggleConfirmPasswordVisibility,
                    isVisible: controller.isConfirmPasswordVisible,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildButtons(RegisterController controller) {
    return Column(
      children: [
        Obx(
          () => ElevatedButton(
            onPressed: controller.isLoading ? () {} : controller.submit,
            child: controller.isLoading
                ? const CircularProgressIndicator()
                : const Text(StringConstants.signupButton),
          ),
        ),
        const CustomDivider(),
        ElevatedButton(
          onPressed: controller.goToLogin,
          child: const Text(StringConstants.loginButtonInRegister),
        ),
      ],
    );
  }
}
