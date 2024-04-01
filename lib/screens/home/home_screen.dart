// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/priority.dart';

import '../../models/task_model.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/padding.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/route_names.dart';
import 'home_controller.dart';

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
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildBody(controller),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Task Manager'),
      centerTitle: true,
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => Get.toNamed(RouteName.addTask.name),
      backgroundColor: ColorConstants.onPrimary,
      foregroundColor: ColorConstants.secondaryColor,
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
    );
  }

  Padding _buildBody(HomeController controller) {
    return Padding(
      padding: PaddingConstants.all16,
      child: Obx(
        () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TasksListView(controller: controller),
      ),
    );
  }

  double get calculateAvailableScreenHeight {
    return Get.height -
        Get.mediaQuery.padding.bottom -
        kToolbarHeight -
        kBottomNavigationBarHeight;
  }
}

class TasksListView extends StatelessWidget {
  TasksListView({
    super.key,
    required this.controller,
  });

  final HomeController controller;
  late List<TaskModel> tasks;

  void initialize() {
    tasks = controller.tasks;
    tasks.sort((a, b) {
      if (a.dueDate == null || b.dueDate == null) {
        return 0;
      } else {
        return a.dueDate!.compareTo(b.dueDate!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initialize();

    return controller.tasks.isEmpty
        ? const Text('No tasks', style: TextStyleConstants.bodyMedium)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tasks', style: TextStyleConstants.bodyMedium),
              const SizedBox(height: 16),
              controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstants.secondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: PaddingConstants.all16,
                          child: Obx(() => _buildTasks()),
                        ),
                      ),
                    ),
            ],
          );
  }

  Widget _buildTasks() {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getTasks();
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: controller.scrollController,
        itemCount: controller.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == controller.tasks.length - 1) {
            return TaskItem(task: controller.tasks[index]);
          } else {
            return Padding(
              padding: PaddingConstants.bottom16,
              child: TaskItem(task: controller.tasks[index]),
            );
          }
        },
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.detailTask.name, arguments: task);
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: ColorConstants.onPrimary,
          border: Border.all(
            color: ColorConstants.secondaryColor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: PaddingConstants.all8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        task.title,
                        style: TextStyleConstants.bodyLargeBold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      task.dueDate != null
                          ? Text(
                              '${DateFormat.d().format(task.dueDate!)} ${DateFormat.MMM().format(task.dueDate!)}, ${DateFormat.jm().format(task.dueDate!)}',
                              style: TextStyleConstants.bodySmall,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                          children: task.tags != null
                              ? task.tags!
                                  .map(
                                    (tag) => InkWell(
                                      onTap: () {
                                        log('${tag.name} tapped');
                                      },
                                      child: Container(
                                        height: 32,
                                        margin: PaddingConstants.right8,
                                        padding: PaddingConstants.all4,
                                        decoration: BoxDecoration(
                                          color: ColorConstants.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          tag.name,
                                          style: TextStyleConstants.bodySmall
                                              .copyWith(
                                            color: ColorConstants.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()
                              : const []),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    task.priority.value,
                    style: TextStyleConstants.bodySmallBold,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*

GestureDetector(
                            onTap: () {
                              log('Tag1 tapped');
                            },
                            child: const Text(
                              '#tag1',
                              style: TextStyleConstants.bodySmall,
                            ),
                          )*/