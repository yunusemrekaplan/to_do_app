import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/task_model.dart';
import '../screens/home/home_controller.dart';
import '../utils/constants/color.dart';
import '../utils/constants/padding.dart';
import '../utils/constants/text_style.dart';
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
    return tasks.isEmpty
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
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == tasks.length - 1) {
            return TaskItem(task: tasks[index]);
          } else {
            return Padding(
              padding: PaddingConstants.bottom16,
              child: TaskItem(task: tasks[index]),
            );
          }
        },
      ),
    );
  }
}
