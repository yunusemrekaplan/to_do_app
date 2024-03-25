class UserModel {
  String? userUid;
  final String email;
  final String fullName;
  final String password;

  UserModel({
    this.userUid,
    required this.email,
    required this.fullName,
    required this.password,
  });

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
      'userUid': userUid,
      'email': email,
      'fullName': fullName,
      'password': password,
    };
  }

  static UserModel? currentUser;
}
