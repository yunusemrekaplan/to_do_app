class UserModel {
  String? _userUid;
  String _email;
  String _fullName;
  String _password;

  UserModel({
    String? userUid,
    required String email,
    required String fullName,
    required String password,
  })  : _password = password,
        _fullName = fullName,
        _email = email,
        _userUid = userUid;

  String? get userUid => _userUid;
  String get email => _email;
  String get fullName => _fullName;
  String get password => _password;

  set setUserUid(String? userUid) => _userUid = userUid;
  set setEmail(String email) => _email = email;
  set setFullName(String fullName) => _fullName = fullName;
  set setPassword(String password) => _password = password;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userUid: json['userUid'],
      email: json['email'],
      fullName: json['fullName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userUid': _userUid,
      'email': _email,
      'fullName': _fullName,
      'password': _password,
    };
  }

  static UserModel? currentUser;
}
