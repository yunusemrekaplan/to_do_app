class TagModel {
  String? _uid;
  String _name;

  TagModel({String? uid, required String name})
      : _name = name,
        _uid = uid;

  String? get uid => _uid;
  String get name => _name;

  set setUid(String uid) => _uid = uid;

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      uid: json['uid'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': _uid,
      'name': _name,
    };
  }
}
