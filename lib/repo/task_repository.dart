import 'package:get/get.dart';

import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskRepository {
  static final TaskRepository _taskRepository = TaskRepository._internal();

  factory TaskRepository() => _taskRepository;

  TaskRepository._internal();

  final TaskService _taskService = TaskService();

  final RxList<TaskModel> _tasks = <TaskModel>[].obs;

  List<TaskModel> get tasks => _tasks;

  Future<bool> addTask(TaskModel task) async {
    bool isAdded = false;
    TaskModel? newTask = await _taskService.addTask(task);

    if (newTask != null) {
      isAdded = true;
      _tasks.add(task);
    }
    return isAdded;
  }

  Future<List<TaskModel>> getTasks() async {
    _tasks.value = await _taskService.getTasks();
    return tasks;
  }

  Future<List<TaskModel>> getIncompleteTasks() async {
    List<TaskModel> newTasks = [];
    newTasks = await _taskService.getFilteredTasks(
      field: 'isCompleted',
      value: false,
    );

    return newTasks;
  }

  Future<List<TaskModel>> getCompletedTasks() async {
    List<TaskModel> newTasks = [];
    newTasks = await _taskService.getFilteredTasks(
      field: 'isCompleted',
      value: true,
    );

    return newTasks;
  }

  Future<List<TaskModel>> getTasksWithMultipleFilters({
    required Map<String, dynamic> filters,
  }) async {
    List<TaskModel> newTasks = [];
    newTasks = await _taskService.getTasksWithMultipleFilters(filters: filters);

    return newTasks;
  }

  Future<bool> updateTask(TaskModel task) async {
    bool isUpdated = false;
    TaskModel? updatedTask = await _taskService.updateTask(task);

    if (updatedTask != null) {
      isUpdated = true;
      int index = _tasks.indexWhere((element) => element.uid == task.uid);
      _tasks[index] = task;
    }
    return isUpdated;
  }
}
