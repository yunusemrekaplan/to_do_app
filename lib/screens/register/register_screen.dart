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
      appBar: AppBar(title: const Text(StringConstant.appName)),
      body: _buildBody(controller),
    );
  }

  Padding _buildBody(RegisterController controller) {
    return Padding(
      padding: PaddingConstant.all16,
      child: SingleChildScrollView(
        child: SizedBox(
          height: DoubleConstant.calculateAvailableScreenHeight,
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
                  StringConstant.signup,
                  style: TextStyleConstant.titleMediumBold,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: controller.fullNameController,
                  hintText: StringConstant.fullNameHintText,
                  validator: CustomValidator().validateFullName,
                ),
                CustomTextFormField(
                  controller: controller.emailController,
                  hintText: StringConstant.emailHintText,
                  validator: CustomValidator().validateEmail,
                ),
                Obx(
                  () => CustomTextFormField(
                    controller: controller.passwordController,
                    hintText: StringConstant.passwordHintText,
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
                    hintText: StringConstant.confirmPasswordHintText,
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
                : const Text(StringConstant.signupButton),
          ),
        ),
        const CustomDivider(),
        ElevatedButton(
          onPressed: controller.goToLogin,
          child: const Text(StringConstant.loginButtonInRegister),
        ),
      ],
    );
  }
}
