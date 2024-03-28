import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/priority.dart';
import '../../models/tag_model.dart';
import '../../models/task_model.dart';
import '../../repo/tag_repository.dart';
import '../../repo/task_repository.dart';

class AddTaskController extends GetxController {
  final _taskRepository = TaskRepository();
  final _tagRepository = TagRepository();

  final _task = Rx<TaskModel?>(null);
  final _isLoading = false.obs;
  final _formKey = GlobalKey<FormState>();
  final _autovalidateMode = AutovalidateMode.disabled.obs;
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  final _taskNotesController = TextEditingController();
  final _taskDateController = TextEditingController();
  final _addTagController = TextEditingController();
  final _selectedPriority = Rx<Priority?>(null);
  final _selectedTags = <TagModel>[].obs;

  DateTime? selectedDate;

  List<TagModel> get tags => _tagRepository.tags;
  List<TagModel> get selectedTags => _selectedTags;

  TaskModel? get task => _task.value;
  bool get isLoading => _isLoading.value;
  GlobalKey<FormState> get formKey => _formKey;
  AutovalidateMode get autovalidateMode => _autovalidateMode.value;
  Priority? get selectedPriority => _selectedPriority.value;
  TextEditingController get taskTitleController => _taskNameController;
  TextEditingController get taskDescriptionController =>
      _taskDescriptionController;
  TextEditingController get taskNotesController => _taskNotesController;
  TextEditingController get taskDateController => _taskDateController;
  TextEditingController get addTagController => _addTagController;

  set task(TaskModel? value) => _task.value = value;
  set isLoading(bool value) => _isLoading.value = value;
  set autovalidateMode(AutovalidateMode value) =>
      _autovalidateMode.value = value;
  set selectedPriority(Priority? value) => _selectedPriority.value = value;

  Future<void> init() async {
    isLoading = true;
    await _tagRepository.getTags();
    isLoading = false;
  }

  Future<void> onSaveTask() async {
    if (!isLoading) {
      isLoading = true;
      autovalidateMode = AutovalidateMode.always;

      if (formKey.currentState!.validate()) {
        if (selectedPriority == null) {
          Get.snackbar(
            'Error',
            'Please select a priority',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
          );
          isLoading = false;
          return;
        } else if (selectedTags.isEmpty) {
          Get.dialog(
            AlertDialog(
              title: const Text('Warning'),
              content: const Text('Do you want to add a task without tags?'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Get.back();
                    await addTask();
                    Get.back();
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('No'),
                ),
              ],
            ),
          );
        } else {
          await addTask();
          Get.back();
        }
      }

      isLoading = false;
    }
  }

  Future<void> addTask() async {
    final task = TaskModel(
      title: taskTitleController.text,
      description: taskDescriptionController.text,
      notes: taskNotesController.text,
      createdDate: DateTime.now(),
      date: selectedDate,
      priority: selectedPriority!,
      tags: selectedTags,
    );

    final isAdded = await _taskRepository.addTask(task);

    if (isAdded) {
      Get.back();
    } else {
      Get.snackbar(
        'Error',
        'Failed to add task',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: Get.locale, //TODO check if this is correct
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: selectedDate != null
            ? TimeOfDay.fromDateTime(selectedDate!)
            : TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        selectedDate = finalDateTime;
        taskDateController.text =
            DateFormat('yyyy-MM-dd HH:mm').format(finalDateTime);
      }
    }
  }

  void pickPriority(Priority? priority) {
    selectedPriority = priority;
  }

  void pickTag(TagModel tag) {
    if (!selectedTags.contains(tag)) {
      selectedTags.add(tag);
    }
  }

  void removeTag(TagModel tag) {
    selectedTags.remove(tag);
  }

  Future<void> addTag() async {
    final tag = TagModel(
      name: addTagController.text,
    );

    final isAdded = await _tagRepository.addTag(tag);

    if (isAdded) {
      addTagController.clear();
      selectedTags.add(tag);
    } else {
      Get.snackbar(
        'Error',
        'Failed to add tag',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}
