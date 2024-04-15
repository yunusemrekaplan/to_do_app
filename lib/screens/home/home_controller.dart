import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/task_model.dart';
import '../../repo/task_repository.dart';
import '../../utils/constants/color.dart';
import '../filter_screen/filter_screen.dart';

class HomeController extends GetxController {
  final TaskRepository _taskRepository = TaskRepository();

  final _filteredTasks = <TaskModel>[].obs;

  final _searchTextController = TextEditingController();
  final _scrollController = ScrollController();

  final _isLoading = false.obs;
  final _tabIndex = false.obs;

  final _incompleteTabColor = ColorConstant.secondaryColor.obs;
  final _incompleteTabTextColor = ColorConstant.primaryColor.obs;
  final _completedTabColor = ColorConstant.onPrimary.obs;
  final _completedTabTextColor = ColorConstant.secondaryColor.obs;

  List<TaskModel> get tasks => _taskRepository.tasks;
  List<TaskModel> get filteredTasks => _filteredTasks;
  TextEditingController get searchTextController => _searchTextController;
  ScrollController get scrollController => _scrollController;
  bool get isLoading => _isLoading.value;
  bool get tabIndex => _tabIndex.value;

  Color get incompleteTabColor => _incompleteTabColor.value;
  Color get incompleteTabTextColor => _incompleteTabTextColor.value;
  Color get completedTabColor => _completedTabColor.value;
  Color get completedTabTextColor => _completedTabTextColor.value;
  Color get filterButtonBoxColor =>
      isLoading ? ColorConstant.onPrimary : ColorConstant.secondaryColor;

  Future<void> init() async {
    _isLoading.value = true;
    await getTasks();

    _isLoading.value = false;
  }

  Future<void> getTasks() async {
    log('Getting tasks');
    _taskRepository.getTasks();
    if (!tabIndex) {
      _filteredTasks.value = await _taskRepository.getIncompleteTasks();
    } else {
      _filteredTasks.value = await _taskRepository.getCompletedTasks();
    }

    sortTasks();
  }

  Future<void> onTapIncompleteTab() async {
    if (!isLoading) {
      _isLoading.value = true;
      _tabIndex.value = false;
      _incompleteTabColor.value = ColorConstant.secondaryColor;
      _incompleteTabTextColor.value = ColorConstant.primaryColor;
      _completedTabColor.value = ColorConstant.onPrimary;
      _completedTabTextColor.value = ColorConstant.secondaryColor;

      _searchTextController.clear();
      _filteredTasks.value = await _taskRepository.getIncompleteTasks();

      _isLoading.value = false;
    }
  }

  Future<void> onTapCompletedTab() async {
    if (!isLoading) {
      _isLoading.value = true;
      _tabIndex.value = true;
      _incompleteTabColor.value = ColorConstant.onPrimary;
      _incompleteTabTextColor.value = ColorConstant.secondaryColor;
      _completedTabColor.value = ColorConstant.secondaryColor;
      _completedTabTextColor.value = ColorConstant.primaryColor;

      _searchTextController.clear();
      _filteredTasks.value = await _taskRepository.getCompletedTasks();

      _isLoading.value = false;
    }
  }

  Future<void> searchTasks(String? value) async {
    _isLoading.value = true;

    if (value != null) {
      _filteredTasks.value = tasks
          .where((task) =>
              (task.title.toLowerCase().contains(value.toLowerCase()) &&
                  (task.isCompleted == tabIndex)))
          .toList();
    }

    _isLoading.value = false;
  }

  void sortTasks() {
    _filteredTasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  showFilterScreen() {
    Get.dialog(
      FilterScreen(),
    );
  }
}
