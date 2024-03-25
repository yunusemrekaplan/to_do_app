class AuthResult {
  final DateTime requestTime;
  String code;
  String? errorMessage;
  final String? token;
  final String? userUid;

  AuthResult({
    required this.requestTime,
    required this.code,
    this.errorMessage,
    this.token,
    this.userUid,
  });

  factory AuthResult.fromJson(Map<String, dynamic> json) {
    return AuthResult(
      requestTime: DateTime.parse(json['requestTime']),
      code: json['code'],
      errorMessage: json['errorMessage'],
      token: json['token'],
      userUid: json['userUid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestTime': requestTime.toIso8601String(),
      'code': code,
      'errorMessage': errorMessage,
      'token': token,
      'userUid': userUid,
    };
  }
}
