import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/main/main_controller.dart';

import '../../utils/constants/color.dart';
import '../../utils/route_names.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _mainController,
      builder: (controller) => Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomBar(pageController: pageController),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => Get.toNamed(RouteName.addTask.name),
      backgroundColor: ColorConstant.onPrimary,
      foregroundColor: ColorConstant.secondaryColor,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, size: 30),
    );
  }
}
