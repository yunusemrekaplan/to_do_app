import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants/padding.dart';
import '../utils/constants/text_style.dart';
import '../utils/route_names.dart';
import '../widgets/divider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Manager',
          style: TextStyleConstants.appBarTitle,
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: PaddingConstants.all16,
      child: SingleChildScrollView(
        child: SizedBox(
          height: calculateAvailableScreenHeight,
          child: _buildSplash(),
        ),
      ),
    );
  }

  Column _buildSplash() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Center(
              child: Image.asset('assets/images/splash.png'),
            ),
            _buildSplashDescription(),
          ],
        ),
        _buildButtons(),
      ],
    );
  }

  Column _buildSplashDescription() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: PaddingConstants.horizontal8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create task efficiently',
                style: TextStyleConstants.titleLargeBold,
              ),
              SizedBox(height: 8),
              Text(
                'Easily add, edit and delete tasks, set reminders, and organize into categories...',
                style: TextStyleConstants.bodyMedium,
              )
            ],
          ),
        ),
      ],
    );
  }

  Column _buildButtons() {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Get.offAllNamed(RouteNames.register);
          },
          child: const Text('Start'),
        ),
        const CustomDivider(),
        TextButton(
          onPressed: () {
            Get.offAllNamed(RouteNames.login);
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
