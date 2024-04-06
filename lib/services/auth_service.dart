import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/auth_result.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  AuthService._internal();

  final _auth = FirebaseAuth.instance;

  Future<AuthResult> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    AuthResult result = AuthResult(requestTime: DateTime.now(), code: '');
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        String? token = await userCredential.user!.getIdToken();
        String userId = userCredential.user!.uid;

        result = AuthResult(
          requestTime: result.requestTime,
          code: '200',
          token: token!,
          userUid: userId,
        );
      } else {
        result = AuthResult(
          requestTime: result.requestTime,
          code: '401',
          errorMessage: 'User not found',
        );
      }
    } on FirebaseAuthException catch (e) {
      result = AuthResult(
        requestTime: result.requestTime,
        code: '401',
        errorMessage: e.message,
      );
      log('signInWithEmailAndPassword: ${e.message}');
    }
    return result;
  }

  Future<AuthResult> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    AuthResult result = AuthResult(requestTime: DateTime.now(), code: '');

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        String? token = await userCredential.user!.getIdToken();
        String userId = userCredential.user!.uid;

        result = AuthResult(
          requestTime: result.requestTime,
          code: '200',
          token: token!,
          userUid: userId,
        );
      } else {
        result = AuthResult(
          requestTime: result.requestTime,
          code: '401',
          errorMessage: 'User not created',
        );
      }
    } on FirebaseAuthException catch (e) {
      result = AuthResult(
        requestTime: result.requestTime,
        code: '401',
        errorMessage: e.message,
      );
      log('registerWithEmailAndPassword: ${e.message}');
    }

    return result;
  }

  Future signInWithGoogle() async {
    _auth.signInWithPopup(GoogleAuthProvider());
  }

  Future sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        return await user.sendEmailVerification();
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future sendPasswordResetEmail(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteUser() async {
    try {
      final user = _auth.currentUser;
      return await user!.delete();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}
