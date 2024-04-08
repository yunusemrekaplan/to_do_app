import 'package:flutter/material.dart';
import '../utils/constants/double.dart';
import '../utils/constants/images.dart';
import '../utils/constants/padding.dart';
import '../utils/constants/string.dart';
import '../utils/constants/text_style.dart';
import '../utils/navigator.dart';
import '../widgets/divider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstant.appName)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: PaddingConstant.all16,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: DoubleConstant.calculateAvailableScreenHeight,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSplashImage(),
                _buildSplashDescription(),
                _buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSplashImage() {
    return Center(
      child: Image.asset(ImageConstant.splash),
    );
  }

  Widget _buildSplashDescription() {
    return const Padding(
      padding: PaddingConstant.horizontal8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringConstant.splashDescriptionTitle,
            style: TextStyleConstant.titleLargeBold,
          ),
          SizedBox(height: 8),
          Text(
            StringConstant.splashDescription,
            style: TextStyleConstant.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => CustomNavigator.goToRegisterScreen,
          child: const Text(StringConstant.startButton),
        ),
        const CustomDivider(),
        ElevatedButton(
          onPressed: () => CustomNavigator.goToLogInScreen,
          child: const Text(StringConstant.loginButtonInSplash),
        ),
      ],
    );
  }
}
