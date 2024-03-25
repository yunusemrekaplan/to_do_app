import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/padding.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/route_names.dart';
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
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Sign Up',
              style: TextStyleConstants.appBarTitle,
            ),
            centerTitle: true,
          ),
          body: _buildBody(controller),
        );
      },
    );
  }

  Padding _buildBody(RegisterController controller) {
    return Padding(
      padding: PaddingConstants.all16,
      child: SingleChildScrollView(
        child: SizedBox(
          height: calculateAvailableScreenHeight,
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
          autovalidateMode: controller.isAutoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Sign Up to Get Started',
                  style: TextStyleConstants.titleMediumBold,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: controller.fullNameController,
                  hintText: 'Full Name',
                  validator: FormValidator.validateFullName,
                ),
                CustomTextFormField(
                  controller: controller.emailController,
                  hintText: 'Email',
                  validator: FormValidator.validateEmail,
                ),
                Obx(
                  () => CustomTextFormField(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    validator: FormValidator.validatePassword,
                    isObscureText: true,
                    toggleVisibility: controller.togglePasswordVisibility,
                    isVisible: controller.isPasswordVisible,
                  ),
                ),
                Obx(
                  () => CustomTextFormField(
                    controller: controller.confirmPasswordController,
                    confirmPasswordController: controller.passwordController,
                    hintText: 'Confirm Password',
                    validator: FormValidator.validateConfirmPassword,
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
          () => TextButton(
            onPressed: controller.isLoading ? () {} : controller.submit,
            child: controller.isLoading
                ? const CircularProgressIndicator()
                : const Text('Sign Up'),
          ),
        ),
        const CustomDivider(),
        TextButton(
          onPressed: () {
            if (controller.isLoading) return;
            Get.offNamed(RouteNames.login);
          },
          child: const Text('Already have an account? Log in'),
        ),
      ],
    );
  }

  double get calculateAvailableScreenHeight {
    return Get.height -
        Get.mediaQuery.padding.bottom -
        kToolbarHeight -
        kBottomNavigationBarHeight;
  }
}
