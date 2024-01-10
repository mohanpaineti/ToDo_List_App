// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Priority { low, medium, high }

enum Status { newTask, inProgress, completed }

Priority parsePriority(String priorityString) {
  switch (priorityString.toLowerCase()) {
    case 'low':
      return Priority.low;
    case 'medium':
      return Priority.medium; 
    case 'high':
      return Priority.high;
    default:
      throw ArgumentError('Invalid priority string: $priorityString');
  }
}


class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority;
  final String category;
  final String status;

  Task({
     this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.category,
    required this.status,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? priority,
    String? category,
    String? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'category': category,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      dueDate: DateTime(map['dueDate'] as int),
      priority: map['priority'] as String,
      category: map['category'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, dueDate: $dueDate, priority: $priority, category: $category, status: $status)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.dueDate == dueDate &&
      other.priority == priority &&
      other.category == category &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      dueDate.hashCode ^
      priority.hashCode ^
      category.hashCode ^
      status.hashCode;
  }
}
