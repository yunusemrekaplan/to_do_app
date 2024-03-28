enum Priority { low, medium, high }

extension PriorityExtension on Priority {
  String get name {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
    }
  }
}

extension StringExtension on String {
  Priority toPriority() {
    switch (this) {
      case 'Low':
        return Priority.low;
      case 'Medium':
        return Priority.medium;
      case 'High':
        return Priority.high;
      default:
        return Priority.low;
    }
  }
}
