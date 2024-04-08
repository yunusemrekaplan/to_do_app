import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/task_model.dart';
import '../screens/home/home_controller.dart';
import '../utils/constants/padding.dart';
import 'task_item.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({
    super.key,
    required this.controller,
    required this.tasks,
  });

  final HomeController controller;
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Expanded(
                child: Obx(
                  () => _buildTasks(),
                ),
              ),
      ],
    );
  }

  Widget _buildTasks() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.searchTextController.clear();
        await controller.getTasks();
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: controller.scrollController,
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == tasks.length - 1) {
            return TaskItem(task: tasks[index]);
          } else {
            return Padding(
              padding: PaddingConstant.bottom16,
              child: TaskItem(task: tasks[index]),
            );
          }
        },
      ),
    );
  }
}
