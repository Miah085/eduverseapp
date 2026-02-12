/// Student model class for the EduVerse Teacher app

/// Enum for student performance trend
enum StudentTrend {
  up,
  down,
  stable,
}

class Student {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final double progress;
  final int completedModules;
  final int totalModules;
  final String status;
  final DateTime enrollmentDate;
  final List<String> enrolledCourses;
  final int overallScore;
  final StudentTrend trend;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    this.progress = 0.0,
    this.completedModules = 0,
    this.totalModules = 0,
    this.status = 'active',
    DateTime? enrollmentDate,
    this.enrolledCourses = const [],
    this.overallScore = 0,
    this.trend = StudentTrend.stable,
  }) : enrollmentDate = enrollmentDate ?? DateTime.now();

  /// Create a Student instance from JSON data
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String? ?? '',
      progress: (json['progress'] as num).toDouble(),
      completedModules: json['completedModules'] as int? ?? 0,
      totalModules: json['totalModules'] as int? ?? 0,
      status: json['status'] as String? ?? 'active',
      enrollmentDate: json['enrollmentDate'] != null
          ? DateTime.parse(json['enrollmentDate'] as String)
          : DateTime.now(),
      enrolledCourses: (json['enrolledCourses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      overallScore: json['overallScore'] as int? ?? 0,
      trend: _trendFromString(json['trend'] as String?),
    );
  }

  /// Helper to convert string to StudentTrend
  static StudentTrend _trendFromString(String? trend) {
    switch (trend?.toLowerCase()) {
      case 'up':
        return StudentTrend.up;
      case 'down':
        return StudentTrend.down;
      default:
        return StudentTrend.stable;
    }
  }

  /// Convert Student instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'progress': progress,
      'completedModules': completedModules,
      'totalModules': totalModules,
      'status': status,
      'enrollmentDate': enrollmentDate.toIso8601String(),
      'enrolledCourses': enrolledCourses,
      'overallScore': overallScore,
      'trend': trend.name,
    };
  }

  /// Create a copy of the Student with updated fields
  Student copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    double? progress,
    int? completedModules,
    int? totalModules,
    String? status,
    DateTime? enrollmentDate,
    List<String>? enrolledCourses,
    int? overallScore,
    StudentTrend? trend,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      progress: progress ?? this.progress,
      completedModules: completedModules ?? this.completedModules,
      totalModules: totalModules ?? this.totalModules,
      status: status ?? this.status,
      enrollmentDate: enrollmentDate ?? this.enrollmentDate,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      overallScore: overallScore ?? this.overallScore,
      trend: trend ?? this.trend,
    );
  }

  /// Get student's initials for avatar fallback
  String get initials {
    final names = name.split(' ');
    if (names.length > 1) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return name.length > 1 ? name.substring(0, 2).toUpperCase() : name[0].toUpperCase();
  }

  /// Check if student is active
  bool get isActive => status.toLowerCase() == 'active';

  @override
  String toString() {
    return 'Student(id: $id, name: $name, email: $email, progress: $progress%, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.id == id &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}