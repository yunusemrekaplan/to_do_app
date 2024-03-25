import 'priority.dart';

class TaskModel {
  final String title;
  final String description;
  final String? notes;
  final DateTime startDate;
  final DateTime dueDate;
  final Priority priority;
  final String category;

  TaskModel({
    required this.title,
    required this.description,
    this.notes,
    required this.startDate,
    required this.dueDate,
    required this.priority,
    required this.category,
  });
}
