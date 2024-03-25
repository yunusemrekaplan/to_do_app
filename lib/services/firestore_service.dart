import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internal();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> addDocument({
    required String collection,
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    bool success = false;
    try {
      final collectionRef = db.collection(collection);
      final docRef = collectionRef.doc(uid);
      await docRef.set(data);
      success = true;
    } on Exception catch (e) {
      log('FirestoreService.createDocument: $e');
    }
    return success;
  }

  Future<List<Map<String, dynamic>>?> getAll({
    required String collection,
  }) async {
    List<Map<String, dynamic>>? data;
    try {
      final collectionRef = db.collection(collection);
      final querySnapshot = await collectionRef.get();
      data = querySnapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e) {
      log('FirestoreService.getAll: $e');
    }
    return data;
  }

  Future<Map<String, dynamic>?> getDocumentById({
    required String collection,
    required String uid,
  }) async {
    Map<String, dynamic>? data;
    try {
      final collectionRef = db.collection(collection);
      final docSnapshot = await collectionRef.doc(uid).get();
      data = docSnapshot.data();
    } on Exception catch (e) {
      log('FirestoreService.getDocumentById: $e');
    }
    return data;
  }

  Future<bool> updateDocument({
    required String collection,
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    bool success = false;
    try {
      final collectionRef = db.collection(collection);
      await collectionRef.doc(uid).update(data);
      success = true;
    } on Exception catch (e) {
      log('FirestoreService.setDocument: $e');
    }
    return success;
  }

  Future<bool> deleteDocument({
    required String collection,
    required String uid,
  }) async {
    bool success = false;
    try {
      final collectionRef = db.collection(collection);
      await collectionRef.doc(uid).delete();
      success = true;
    } on Exception catch (e) {
      log('FirestoreService.deleteDocument: $e');
    }
    return success;
  }
}
