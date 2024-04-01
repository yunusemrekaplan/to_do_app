import 'package:get/get.dart';

import '../../models/task_model.dart';
import '../../repo/task_repository.dart';

class TaskDetailController extends GetxController {
  final TaskRepository _taskRepository = TaskRepository();
  final TaskModel task;
  final RxBool isCompleted = false.obs;

  TaskDetailController({required this.task});

  @override
  void onInit() {
    isCompleted.value = task.isCompleted;
    super.onInit();
  }

  void toggleTask() {
    isCompleted.value = !isCompleted.value;
    task.setIsCompleted = isCompleted.value;
    _taskRepository.updateTask(task);
  }
}
