import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() => _instance;

  LocalStorage._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<bool> write({required String key, required String value}) async {
    bool result = false;
    try {
      await _storage.write(key: key, value: value);
      result = true;
    } catch (e) {
      log('LocalStorage.write: $e');
    }
    return result;
  }

  Future<String?> read({required String key}) async {
    String? value;
    try {
      value = await _storage.read(key: key);
    } catch (e) {
      log('LocalStorage.read: $e');
    }
    return value;
  }

  Future<bool> delete({required String key}) async {
    bool result = false;
    try {
      await _storage.delete(key: key);
      result = true;
    } catch (e) {
      log('LocalStorage.delete: $e');
    }
    return result;
  }
}
