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
          appBar: AppBar(title: const Text(StringConstant.appName)),
          body: _buildBody(controller),
        );
      },
    );
  }

  Widget _buildBody(LoginController controller) {
    return Padding(
      padding: PaddingConstant.all16,
      child: _buildLogin(controller),
    );
  }

  Widget _buildLogin(LoginController controller) {
    return SingleChildScrollView(
      child: SizedBox(
        height: DoubleConstant.calculateAvailableScreenHeight,
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
      padding: PaddingConstant.vertical16,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorConstant.secondaryColor.withOpacity(0.8),
          borderRadius: BorderRadiusConstant.borderRadius12,
        ),
        child: Image.asset(ImageConstant.login, height: 200),
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
                  StringConstant.login,
                  style: TextStyleConstant.titleMediumBold,
                ),
                const SizedBox(height: 16),
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
                  StringConstant.loginButton,
                  onPressed: controller.isLoading ? null : controller.submit,
                ),
        ),
        const CustomDivider(),
        Row(
          children: [
            Expanded(
              child: _buildElevatedButton(
                StringConstant.forgotPasswordButton,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildElevatedButton(
                StringConstant.googleSigninButton,
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildElevatedButton(
          StringConstant.signupButtonInLogin,
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
