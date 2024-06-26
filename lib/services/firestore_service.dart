import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DocumentReference?> createDocument({
    required String path,
  }) async {
    DocumentReference? docRef;

    try {
      docRef = _db.collection(path).doc();
    } on Exception catch (e) {
      log('FirestoreService.createDocument: $e');
    }

    return docRef;
  }

  Future<bool> addDocument({
    required String collection,
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    bool success = false;
    try {
      final collectionRef = _db.collection(collection);
      final docRef = collectionRef.doc(uid);
      await docRef.set(data);
      success = true;
    } on Exception catch (e) {
      log('FirestoreService.createDocument: $e');
    }
    return success;
  }

  Future<Map<String, dynamic>?> getDocumentById({
    required String collection,
    required String uid,
  }) async {
    Map<String, dynamic>? data;
    try {
      final collectionRef = _db.collection(collection);
      final docSnapshot = await collectionRef.doc(uid).get();
      data = docSnapshot.data();
    } on Exception catch (e) {
      log('FirestoreService.getDocumentById: $e');
    }
    return data;
  }

  Future<List<Map<String, dynamic>>?> getAll({
    required String collection,
  }) async {
    List<Map<String, dynamic>>? data;
    try {
      log(collection);
      final collectionRef = _db.collection(collection);
      final querySnapshot = await collectionRef.get();
      data = querySnapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e) {
      log('FirestoreService.getAll: $e');
    }
    return data;
  }

  Future<List<Map<String, dynamic>>?> getFilteredDocuments({
    required String collection,
    required String field,
    required dynamic value,
  }) async {
    List<Map<String, dynamic>>? data;
    try {
      final collectionRef = _db.collection(collection);
      final querySnapshot =
          await collectionRef.where(field, isEqualTo: value).get();
      data = querySnapshot.docs.map((doc) => doc.data()).toList();
    } on Exception catch (e) {
      log('FirestoreService.getFilteredDocuments: $e');
    }
    return data;
  }

  Future<List<Map<String, dynamic>>?> getDocumentsWithMultipleFilters({
    required String collection,
    required Map<String, dynamic> filters,
  }) async {
    List<Map<String, dynamic>>? data;
    try {
      Query query = _db.collection(collection);
      filters.forEach((key, value) {
        query = query.where(key, isEqualTo: value);
      });
      final querySnapshot = await query.get();
      data = querySnapshot.docs
          .map((doc) => doc.data())
          .cast<Map<String, dynamic>>()
          .toList();
    } on Exception catch (e) {
      log('FirestoreService.getDocumentsWithMultipleFilters: $e');
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
      final collectionRef = _db.collection(collection);
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
      final collectionRef = _db.collection(collection);
      await collectionRef.doc(uid).delete();
      success = true;
    } on Exception catch (e) {
      log('FirestoreService.deleteDocument: $e');
    }
    return success;
  }
}
