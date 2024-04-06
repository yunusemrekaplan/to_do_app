import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/task_model.dart';
import '../../repo/task_repository.dart';

class HomeController extends GetxController {
  final TaskRepository _taskRepository = TaskRepository();

  final RxList<TaskModel> _filteredTasks = <TaskModel>[].obs;

  final _isLoading = false.obs;

  final scrollController = ScrollController();

  List<TaskModel> get tasks => _taskRepository.tasks;
  List<TaskModel> get filteredTasks => _filteredTasks;
  bool get isLoading => _isLoading.value;

  set setFilteredTask(List<TaskModel> tasks) => _filteredTasks.value = tasks;

  Future<void> init() async {
    _isLoading.value = true;
    await getTasks();

    _isLoading.value = false;
  }

  Future<void> getTasks() async {
    log('Getting tasks');
    await _taskRepository.getTasks();
    sortTasks();
  }

  void sortTasks() {
    List<TaskModel> dueDateNullTasks = [];
    List<TaskModel> dueDateNotNullTasks = [];

    for (var task in tasks) {
      if (task.dueDate == null) {
        dueDateNullTasks.add(task);
      } else {
        dueDateNotNullTasks.add(task);
      }
    }

    dueDateNotNullTasks.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
    setFilteredTask = dueDateNotNullTasks + dueDateNullTasks + [];
  }
}
