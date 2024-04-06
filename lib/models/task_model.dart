import 'attachment_model.dart';
import 'priority.dart';
import 'tag_model.dart';

class TaskModel {
  String? _uid;
  String _title;
  String? _description;
  List<String> _notes = <String>[];
  late DateTime _createdAt;
  DateTime? _dueDate;
  Priority _priority;
  List<TagModel> _tags = <TagModel>[];
  List<AttachmentModel> _attachments;
  bool _isCompleted = false;

  TaskModel({
    String? uid,
    required String title,
    String? description,
    List<String> notes = const <String>[],
    required DateTime createdAt,
    DateTime? dueDate,
    required Priority priority,
    List<TagModel> tags = const <TagModel>[],
    List<AttachmentModel> attachments = const <AttachmentModel>[],
    bool isCompleted = false,
  })  : _uid = uid,
        _title = title,
        _description = description,
        _notes = notes,
        _createdAt = createdAt,
        _dueDate = dueDate,
        _priority = priority,
        _tags = tags,
        _attachments = attachments,
        _isCompleted = isCompleted;

  String? get uid => _uid;
  String get title => _title;
  String? get description => _description;
  List<String>? get notes => _notes;
  DateTime get createdAt => _createdAt;
  DateTime? get dueDate => _dueDate;
  Priority get priority => _priority;
  List<TagModel>? get tags => _tags;
  List<AttachmentModel> get attachments => _attachments;
  bool get isCompleted => _isCompleted;

  set setUid(String? uid) => _uid = uid;
  set setTitle(String title) => _title = title;
  set setDescription(String? description) => _description = description;
  set setNotes(List<String> notes) => _notes = notes;
  set setDueDate(DateTime? dueDate) => _dueDate = dueDate;
  set setPriority(Priority priority) => _priority = priority;
  set setTags(List<TagModel> tags) => _tags = tags;
  set setAttachments(List<AttachmentModel> attachments) =>
      _attachments = attachments;
  set setIsCompleted(bool isCompleted) => _isCompleted = isCompleted;

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      notes: json['notes'].map<String>((note) => note.toString()).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      dueDate: json['dueDate'] == null ? null : DateTime.parse(json['dueDate']),
      priority: json['priority'].toString().toPriority(),
      tags:
          json['tags'].map<TagModel>((tag) => TagModel.fromJson(tag)).toList(),
      attachments: json['attachments']
          .map<AttachmentModel>(
              (attachment) => AttachmentModel.fromJson(attachment))
          .toList(),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': _uid,
      'title': _title,
      'description': _description,
      'notes': _notes,
      'createdAt': _createdAt.toIso8601String(),
      'dueDate': _dueDate?.toIso8601String(),
      'priority': _priority.value,
      'tags': _tags.map((tag) => tag.toJson()).toList(),
      'attachments':
          _attachments.map((attachment) => attachment.toJson()).toList(),
      'isCompleted': _isCompleted,
    };
  }
}
