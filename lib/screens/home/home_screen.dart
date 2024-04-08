import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/color.dart';
import '../../utils/constants/padding.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/route_names.dart';
import '../../widgets/tasks_list_view.dart';
import 'home_controller.dart';
import 'home_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: _homeController,
      initState: (_) => _homeController.init(),
      builder: (controller) {
        return _buildScaffold(controller);
      },
    );
  }

  Scaffold _buildScaffold(HomeController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildBody(controller),
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

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: ColorConstant.secondaryColor,
            size: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: ColorConstant.secondaryColor,
            size: 30,
          ),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        if (index == 1) {
          Get.offAllNamed(RouteName.profile.name);
        }
      },
    );
  }

  Padding _buildBody(HomeController controller) {
    return Padding(
      padding: PaddingConstant.all16,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tasks', style: TextStyleConstant.bodySmallBold),
            const SizedBox(height: 8),
            _buildSearchRow(controller),
            HomeWidgets.buildTabBar(controller),
            Expanded(
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TasksListView(
                      controller: controller,
                      tasks: controller.filteredTasks,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSearchRow(HomeController controller) {
    return Row(
      children: [
        HomeWidgets.buildSearchTextFormField(controller),
        const SizedBox(width: 8),
        HomeWidgets.buildFilterButton(controller),
      ],
    );
  }
}
