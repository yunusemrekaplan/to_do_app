import 'priority.dart';
import 'tag_model.dart';

class TaskModel {
  String? _uid;
  String _title;
  String? _description;
  String? _notes;
  late DateTime _createdDate;
  DateTime? _date;
  Priority _priority;
  List<TagModel>? _tags;

  TaskModel({
    String? uid,
    required String title,
    String? description,
    String? notes,
    required DateTime createdDate,
    DateTime? date,
    required Priority priority,
    List<TagModel>? tags,
  })  : _uid = uid,
        _title = title,
        _description = description,
        _notes = notes,
        _createdDate = createdDate,
        _date = date,
        _priority = priority,
        _tags = tags;

  String? get uid => _uid;
  String get title => _title;
  String? get description => _description;
  String? get notes => _notes;
  DateTime get createdDate => _createdDate;
  DateTime? get date => _date;
  Priority get priority => _priority;
  List<TagModel>? get tags => _tags;

  set setUid(String? uid) => _uid = uid;
  set setTitle(String title) => _title = title;
  set setDescription(String? description) => _description = description;
  set setNotes(String? notes) => _notes = notes;
  set setDate(DateTime? date) => _date = date;
  set setPriority(Priority priority) => _priority = priority;
  set setTags(List<TagModel>? tags) => _tags = tags;

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      notes: json['notes'],
      createdDate: DateTime.parse(json['createdDate']),
      date: json['date'] == null ? null : DateTime.parse(json['date']),
      priority: json['priority'].toString().toPriority(),
      tags:
          json['tags'].map<TagModel>((tag) => TagModel.fromJson(tag)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': _uid,
      'title': _title,
      'description': _description,
      'notes': _notes,
      'createdDate': _createdDate.toIso8601String(),
      'date': _date?.toIso8601String(),
      'priority': _priority.name,
      'tags': _tags?.map((tag) => tag.toJson()).toList(),
    };
  }
}
