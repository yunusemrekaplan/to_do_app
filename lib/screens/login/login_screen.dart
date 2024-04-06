import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/border_radius.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/double.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/padding.dart';
import '../../utils/constants/string.dart';
import '../../utils/constants/text_style.dart';
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
          appBar: AppBar(title: const Text(StringConstants.appName)),
          body: _buildBody(controller),
        );
      },
    );
  }

  Widget _buildBody(LoginController controller) {
    return Padding(
      padding: PaddingConstants.all16,
      child: _buildLogin(controller),
    );
  }

  Widget _buildLogin(LoginController controller) {
    return SingleChildScrollView(
      child: SizedBox(
        height: DoubleConstants.calculateAvailableScreenHeight,
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

  Widget _buildImageContainer() {
    return Padding(
      padding: PaddingConstants.vertical16,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorConstants.secondaryColor.withOpacity(0.8),
          borderRadius: BorderRadiusConstants.borderRadius12,
        ),
        child: Image.asset(ImageConstants.login, height: 200),
      ),
    );
  }

  Widget _buildForm(LoginController controller) {
    return Expanded(
      child: Obx(
        () => Form(
          key: controller.formKey,
          autovalidateMode: controller.autovalidateMode,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  StringConstants.login,
                  style: TextStyleConstants.titleMediumBold,
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(LoginController controller) {
    return Column(
      children: [
        Obx(
          () => controller.isLoading
              ? ElevatedButton(
                  onPressed: () {},
                  child: const CircularProgressIndicator(),
                )
              : _buildElevatedButton(
                  StringConstants.loginButton,
                  onPressed: controller.isLoading ? null : controller.submit,
                ),
        ),
        const CustomDivider(),
        Row(
          children: [
            Expanded(
              child: _buildElevatedButton(
                StringConstants.forgotPasswordButton,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildElevatedButton(
                StringConstants.googleSigninButton,
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildElevatedButton(
          StringConstants.signupButtonInLogin,
          onPressed: controller.goToSignup,
        ),
      ],
    );
  }

  Widget _buildElevatedButton(String text, {Function()? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
