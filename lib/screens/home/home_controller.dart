import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/task_model.dart';
import '../../repo/task_repository.dart';

class HomeController extends GetxController {
  final TaskRepository _taskRepository = TaskRepository();

  final _tasks = <TaskModel>[].obs;
  final _isLoading = false.obs;

  final scrollController = ScrollController();

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading.value;

  Future<void> init() async {
    _isLoading.value = true;
    await getTasks();

    _isLoading.value = false;
  }

  Future<void> getTasks() async {
    log('Getting tasks');
    _tasks.value = await _taskRepository.getTasks();
  }
}
