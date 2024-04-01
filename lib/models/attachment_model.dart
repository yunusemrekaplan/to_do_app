// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AttachmentModel {
  final String _name;
  final String? _path;
  String? _url;

  AttachmentModel({
    required String name,
    String? path,
    String? url,
  })  : _path = path,
        _name = name,
        _url = url;

  String get name => _name;
  String? get path => _path;
  String? get url => _url;

  set url(String? url) => _url = url;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': _name,
      'url': _url,
    };
  }

  factory AttachmentModel.fromMap(Map<String, dynamic> map) {
    return AttachmentModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttachmentModel.fromJson(String source) =>
      AttachmentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
