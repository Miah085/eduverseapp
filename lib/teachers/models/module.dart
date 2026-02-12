import 'package:flutter/material.dart';

/// Module model class for the EduVerse Teacher app
class Module {
  final String id;
  final String title;
  final String subject;
  final String status;
  final int students;
  final int lessons;
  final String lastUpdated;
  final Color color;
  final String? description;
  final DateTime createdDate;
  final List<String> tags;

  const Module({
    required this.id,
    required this.title,
    required this.subject,
    required this.status,
    required this.students,
    required this.lessons,
    required this.lastUpdated,
    required this.color,
    this.description,
    required this.createdDate,
    this.tags = const [],
  });

  /// Create a Module instance from JSON data
  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
      students: json['students'] as int? ?? 0,
      lessons: json['lessons'] as int? ?? 0,
      lastUpdated: json['lastUpdated'] as String? ?? '',
      color: _colorFromJson(json['color']),
      description: json['description'] as String?,
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'] as String)
          : DateTime.now(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }

  /// Convert Module instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'status': status,
      'students': students,
      'lessons': lessons,
      'lastUpdated': lastUpdated,
      'color': color.value,
      'description': description,
      'createdDate': createdDate.toIso8601String(),
      'tags': tags,
    };
  }

  /// Helper method to convert color from JSON
  static Color _colorFromJson(dynamic colorValue) {
    if (colorValue == null) return Colors.blue;
    
    if (colorValue is int) {
      return Color(colorValue);
    }
    
    if (colorValue is String) {
      // Remove '#' if present and parse hex
      final hexColor = colorValue.replaceAll('#', '');
      return Color(int.parse('0xFF$hexColor'));
    }
    
    return Colors.blue;
  }

  /// Create a copy of the Module with updated fields
  Module copyWith({
    String? id,
    String? title,
    String? subject,
    String? status,
    int? students,
    int? lessons,
    String? lastUpdated,
    Color? color,
    String? description,
    DateTime? createdDate,
    List<String>? tags,
  }) {
    return Module(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      status: status ?? this.status,
      students: students ?? this.students,
      lessons: lessons ?? this.lessons,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      color: color ?? this.color,
      description: description ?? this.description,
      createdDate: createdDate ?? this.createdDate,
      tags: tags ?? this.tags,
    );
  }

  /// Check if module is active
  bool get isActive => status.toLowerCase() == 'active';

  /// Check if module is archived
  bool get isArchived => status.toLowerCase() == 'archived';

  /// Get completion percentage
  double get completionRate {
    if (lessons == 0) return 0.0;
    // This is a placeholder - you would calculate based on completed lessons
    return 75.0;
  }

  @override
  String toString() {
    return 'Module(id: $id, title: $title, subject: $subject, students: $students, lessons: $lessons)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Module &&
        other.id == id &&
        other.title == title &&
        other.subject == subject;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ subject.hashCode;
}