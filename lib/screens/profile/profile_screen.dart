import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../utils/constants/border_radius.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/padding.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/route_names.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: _profileController,
      builder: (controller) => _buildScaffold(controller),
    );
  }

  Scaffold _buildScaffold(ProfileController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: _buildBody(controller),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 1,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: ColorConstants.secondaryColor,
            size: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: ColorConstants.secondaryColor,
            size: 30,
          ),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Get.offAllNamed(RouteName.home.name);
        }
      },
    );
  }

  Widget _buildBody(ProfileController controller) {
    return Padding(
      padding: PaddingConstants.all16,
      child: Obx(
        () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: ColorConstants.secondaryColor,
                      child: Icon(
                        Icons.person,
                        size: 48,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        UserModel.currentUser!.fullName,
                        style: TextStyleConstants.bodyMediumBold,
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox(height: 16)),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        //color: ColorConstants.onPrimary,
                        borderRadius: BorderRadiusConstants.borderRadius12,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: PaddingConstants.all16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    splashColor: ColorConstants.onPrimary,
                                    onTap: () {
                                      log('onTap');
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.person, size: 32),
                                        SizedBox(width: 16),
                                        Text(
                                          'Full name',
                                          style:
                                              TextStyleConstants.bodyMediumBold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: PaddingConstants.all16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    splashColor: ColorConstants.onPrimary,
                                    onTap: () {
                                      log('onTap');
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.email, size: 32),
                                        SizedBox(width: 16),
                                        Text(
                                          'Email',
                                          style:
                                              TextStyleConstants.bodyMediumBold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: PaddingConstants.all16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    splashColor: ColorConstants.onPrimary,
                                    onTap: () {
                                      log('onTap');
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.lock, size: 32),
                                        SizedBox(width: 16),
                                        Text(
                                          'Password',
                                          style:
                                              TextStyleConstants.bodyMediumBold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: PaddingConstants.all16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    splashColor: ColorConstants.onPrimary,
                                    onTap: controller.signOut,
                                    child: const Row(
                                      children: [
                                        Icon(Icons.exit_to_app, size: 32),
                                        SizedBox(width: 16),
                                        Text(
                                          'Log Out',
                                          style:
                                              TextStyleConstants.bodyMediumBold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
