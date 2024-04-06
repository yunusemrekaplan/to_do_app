import 'dart:developer';

import '../models/task_model.dart';
import '../models/user_model.dart';
import 'firestore_service.dart';

class TaskService {
  static final TaskService _taskService = TaskService._internal();

  factory TaskService() => _taskService;

  TaskService._internal();

  final _firestoreService = FirestoreService();

  Future<TaskModel?> addTask(TaskModel task) async {
    TaskModel? newTask;

    final docRef = await _firestoreService.createDocument(
      path: 'users/${UserModel.currentUser!.userUid}/tasks',
    );
    if (docRef != null) {
      task.setUid = docRef.id;
      await _firestoreService.addDocument(
        collection: 'users/${UserModel.currentUser!.userUid}/tasks',
        uid: task.uid!,
        data: task.toJson(),
      );
      newTask = task;
    } else {
      log('TaskService.addTask: docRef is null');
    }
    return newTask;
  }

  Future<List<TaskModel>> getTasks() async {
    List<TaskModel> tasks = <TaskModel>[];

    final docs = await _firestoreService.getAll(
        collection: 'users/${UserModel.currentUser!.userUid}/tasks');
    if (docs != null) {
      tasks = docs.map((doc) => TaskModel.fromJson(doc)).toList();
    } else {
      log('TaskService.getTasks: docs is null');
    }
    return tasks;
  }

  Future<TaskModel?> updateTask(TaskModel task) async {
    TaskModel? updatedTask;

    await _firestoreService.updateDocument(
      collection: 'users/${UserModel.currentUser!.userUid}/tasks',
      uid: task.uid!,
      data: task.toJson(),
    );
    updatedTask = task;
    return updatedTask;
  }
}
