import '../models/auth_result.dart';
import '../models/user_model.dart';
import 'firestore_service.dart';
import 'auth_service.dart';
import 'local_storage.dart';

class UserService {
  static final UserService _instance = UserService._internal();

  factory UserService() => _instance;

  UserService._internal();

  final _authService = AuthService();
  final _localStorage = LocalStorage();
  final _firestoreService = FirestoreService();

  Future<AuthResult> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final result = await _authService.signInWithEmailAndPassword(
      email,
      password,
    );
    if (result.code == '200') {
      await _localStorage.write(key: 'token', value: result.token!);

      try {
        await getUserAndSetAsCurrentUser(result);
      } on Exception catch (e) {
        result.code = '401';
        result.errorMessage = e.toString();
      }
    }

    return result;
  }

  Future<void> getUserAndSetAsCurrentUser(AuthResult result) async {
    final user = await _firestoreService.getDocumentById(
      collection: 'users',
      uid: result.userUid!,
    );

    if (user != null) {
      UserModel.currentUser = UserModel.fromJson(user);
      await _localStorage.write(key: 'userUid', value: user['userUid']);
    } else {
      result.code = '401';
      result.errorMessage = 'User not found';
    }
  }

  Future<AuthResult> registerWithEmailAndPassword(UserModel userModel) async {
    final result = await _authService.registerWithEmailAndPassword(
      userModel.email,
      userModel.password,
    );

    if (result.code == '200') {
      await _localStorage.write(key: 'token', value: result.token!);

      try {
        await addUserAndSetAsCurrentUser(result, userModel);
      } on Exception catch (e) {
        result.code = '401';
        result.errorMessage = e.toString();
      }
    }

    return result;
  }

  Future<void> addUserAndSetAsCurrentUser(
    AuthResult result,
    UserModel userModel,
  ) async {
    userModel.setUserUid = result.userUid;
    bool success = await _firestoreService.addDocument(
      collection: 'users',
      uid: result.userUid!,
      data: userModel.toJson(),
    );

    if (success) {
      UserModel.currentUser = userModel;
      _localStorage.write(key: 'userUid', value: userModel.userUid!);
    } else {
      result.code = '401';
      result.errorMessage = 'User not created';
    }
  }

  Future<bool> getUserByIdAndSetAsCurrentUser(String userId) async {
    final user = await _firestoreService.getDocumentById(
      collection: 'users',
      uid: userId,
    );

    if (user != null) {
      UserModel.currentUser = UserModel.fromJson(user);
      _localStorage.write(key: 'userUid', value: user['userUid']);
      return true;
    } else {
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    await _localStorage.delete(key: 'token');
    await _localStorage.delete(key: 'refreshToken');
    await _localStorage.delete(key: 'userUid');
  }
}
