import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../models/user_model.dart';

class StorageService {
  static final StorageService _instance = StorageService._();

  StorageService._();

  factory StorageService() => _instance;

  final _storage = FirebaseStorage.instance;

  final String _staticPath = '${UserModel.currentUser!.userUid!}/';

  Future<bool> uploadFile(
    String path,
    String fileName,
    String filePath,
  ) async {
    try {
      final ref = _storage.ref().child(_staticPath + path).child(fileName);
      final uploadTask = ref.putFile(File(filePath));
      final snapshot = await uploadTask.whenComplete(() => null);
      return snapshot.state == TaskState.success;
    } catch (e) {
      print('Error uploading file: $e');
      return false;
    }
  }
}
