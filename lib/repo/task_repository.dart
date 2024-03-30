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
    return _tasks;
  }
}
