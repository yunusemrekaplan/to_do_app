import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/color.dart';
import '../../utils/constants/padding.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/route_names.dart';
import '../../utils/validator.dart';
import '../../widgets/divider.dart';
import '../../widgets/text_form_field.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: _loginController,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Task Manager',
              style: TextStyleConstants.appBarTitle,
            ),
            centerTitle: true,
          ),
          body: _buildBody(controller),
        );
      },
    );
  }

  Padding _buildBody(LoginController controller) {
    return Padding(
      padding: PaddingConstants.all16,
      child: _buildLogin(controller),
    );
  }

  SingleChildScrollView _buildLogin(LoginController controller) {
    return SingleChildScrollView(
      child: SizedBox(
        height: calculateAvailableScreenHeight,
        child: Column(
          children: [
            _buildImageContainer(),
            _buildForm(controller),
            const SizedBox(height: 16),
            _buildButtons(controller),
          ],
        ),
      ),
    );
  }

  Padding _buildImageContainer() {
    return Padding(
      padding: PaddingConstants.vertical16,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorConstants.secondaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset('assets/images/login.png', height: 200),
      ),
    );
  }

  Expanded _buildForm(LoginController controller) {
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
                const SizedBox(height: 16),
                const Text(
                  'Log in',
                  style: TextStyleConstants.titleMediumBold,
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildButtons(LoginController controller) {
    return Column(
      children: [
        Obx(
          () => controller.isLoading
              ? TextButton(
                  onPressed: () {},
                  child: const CircularProgressIndicator(),
                )
              : _buildTextButton(
                  'Log in',
                  onPressed: controller.isLoading ? null : controller.submit,
                ),
        ),
        const CustomDivider(),
        Row(
          children: [
            Expanded(
              child: _buildTextButton(
                'Forgot Password?',
                onPressed: () {
                  if (controller.isLoading) return;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: _buildTextButton(
              'Google',
              onPressed: () {
                if (controller.isLoading) return;
              },
            )),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextButton(
          'New User? Sign Up',
          onPressed: () {
            if (controller.isLoading) return;
            Get.offAllNamed(RouteNames.register);
          },
        ),
      ],
    );
  }

  TextButton _buildTextButton(String text, {Function()? onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  double get calculateAvailableScreenHeight {
    return Get.height -
        Get.mediaQuery.padding.bottom -
        kToolbarHeight -
        kBottomNavigationBarHeight;
  }
}
