import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/animated_card.dart';
import '../widgets/gradient_avatar.dart';
import '../models/student.dart';

class TeacherStudentsScreen extends StatefulWidget {
  const TeacherStudentsScreen({super.key});
  
  @override
  State<TeacherStudentsScreen> createState() => _TeacherStudentsScreenState();
}

class _TeacherStudentsScreenState extends State<TeacherStudentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  
  final List<Student> students = [
    Student(
      id: "1",
      name: 'Jett',
      avatar: 'JT',
      email: 'jett@student.edu',
      overallScore: 92,
      trend: StudentTrend.up,
      completedModules: 7,
      totalModules: 8,
    ),
    Student(
      id: "2",
      name: 'Phoenix',
      avatar: 'PX',
      email: 'phoenix@student.edu',
      overallScore: 88,
      trend: StudentTrend.up,
      completedModules: 6,
      totalModules: 8,
    ),
    Student(
      id: "3",
      name: 'Sage',
      avatar: 'SG',
      email: 'sage@student.edu',
      overallScore: 85,
      trend: StudentTrend.stable,
      completedModules: 6,
      totalModules: 8,
    ),
    Student(
      id: "4",
      name: 'Sova',
      avatar: 'SV',
      email: 'sova@student.edu',
      overallScore: 78,
      trend: StudentTrend.up,
      completedModules: 5,
      totalModules: 8,
    ),
    Student(
      id: "5",
      name: 'Viper',
      avatar: 'VP',
      email: 'viper@student.edu',
      overallScore: 95,
      trend: StudentTrend.up,
      completedModules: 8,
      totalModules: 8,
    ),
    Student(
      id: "6",
      name: 'Brimstone',
      avatar: 'BR',
      email: 'brimstone@student.edu',
      overallScore: 72,
      trend: StudentTrend.down,
      completedModules: 4,
      totalModules: 8,
    ),
    Student(
      id: "7",
      name: 'Reyna',
      avatar: 'RY',
      email: 'reyna@student.edu',
      overallScore: 90,
      trend: StudentTrend.up,
      completedModules: 7,
      totalModules: 8,
    ),
    Student(
      id: "8",
      name: 'Cypher',
      avatar: 'CP',
      email: 'cypher@student.edu',
      overallScore: 81,
      trend: StudentTrend.stable,
      completedModules: 6,
      totalModules: 8,
    ),
    Student(
      id: "9",
      name: 'Killjoy',
      avatar: 'KJ',
      email: 'killjoy@student.edu',
      overallScore: 67,
      trend: StudentTrend.down,
      completedModules: 4,
      totalModules: 8,
    ),
    Student(
      id: "10",
      name: 'Omen',
      avatar: 'OM',
      email: 'omen@student.edu',
      overallScore: 83,
      trend: StudentTrend.up,
      completedModules: 6,
      totalModules: 8,
    ),
  ];
  
  List<Student> get filteredStudents {
    if (searchQuery.isEmpty) return students;
    return students.where((student) {
      return student.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          student.email.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }
  
  List<Color> avatarColors = [
    const Color(0xFF5B7FE3),
    const Color(0xFF8B5CF6),
    const Color(0xFF06B6D4),
    const Color(0xFFF59E0B),
    const Color(0xFFEF4444),
    const Color(0xFF10B981),
    const Color(0xFFEC4899),
  ];
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  Color getPerformanceColor(int score) {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.warning;
    return AppColors.error;
  }
  
  Color getPerformanceBgColor(int score) {
    if (score >= 80) return AppColors.successLight;
    if (score >= 60) return AppColors.warningLight;
    return AppColors.errorLight;
  }
  
  String getPerformanceLabel(int score) {
    if (score >= 80) return 'Strong';
    if (score >= 60) return 'Moderate';
    return 'Needs Help';
  }
  
  Widget getTrendIcon(StudentTrend trend) {
    switch (trend) {
      case StudentTrend.up:
        return const Icon(
          LucideIcons.trendingUp,
          color: AppColors.success,
          size: 16,
        );
      case StudentTrend.down:
        return const Icon(
          LucideIcons.trendingDown,
          color: AppColors.error,
          size: 16,
        );
      case StudentTrend.stable:
        return const Icon(
          LucideIcons.minus,
          color: AppColors.gray400,
          size: 16,
        );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final strongCount = students.where((s) => s.overallScore >= 80).length;
    final moderateCount =
        students.where((s) => s.overallScore >= 60 && s.overallScore < 80).length;
    final needsHelpCount = students.where((s) => s.overallScore < 60).length;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildSummaryStats(strongCount, moderateCount, needsHelpCount),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Text('All Students', style: AppTextStyles.h4),
                    const SizedBox(height: 16),
                    ...filteredStudents.asMap().entries.map((entry) {
                      return _buildStudentCard(entry.value, entry.key);
                    }),
                    if (filteredStudents.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(48),
                          child: Text(
                            'No students found',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.gray500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => context.go('/'),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      LucideIcons.arrowLeft,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Students',
                        style: AppTextStyles.h3.copyWith(color: Colors.white),
                      ),
                      Text(
                        '${students.length} students enrolled',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search students...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.gray400,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.95),
                prefixIcon: const Icon(
                  LucideIcons.search,
                  color: AppColors.gray400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: -0.2, end: 0);
  }
  
  Widget _buildSummaryStats(int strong, int moderate, int needsHelp) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: AnimatedCard(
              delay: 100.ms,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '$strong',
                    style: AppTextStyles.h2.copyWith(color: AppColors.success),
                  ),
                  Text('Strong', style: AppTextStyles.caption),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedCard(
              delay: 150.ms,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '$moderate',
                    style: AppTextStyles.h2.copyWith(color: AppColors.warning),
                  ),
                  Text('Moderate', style: AppTextStyles.caption),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedCard(
              delay: 200.ms,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '$needsHelp',
                    style: AppTextStyles.h2.copyWith(color: AppColors.error),
                  ),
                  Text('Needs Help', style: AppTextStyles.caption),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStudentCard(Student student, int index) {
    final avatarGradient = [
      avatarColors[index % avatarColors.length],
      avatarColors[(index + 1) % avatarColors.length],
    ];
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          context.push('/teacher-student-profile', extra: student);
        },
        child: AnimatedCard(
          delay: (300 + index * 50).ms,
          child: Row(
            children: [
              GradientAvatar(
                text: student.avatar,
                size: 56,
                colors: avatarGradient,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: AppTextStyles.h4,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      student.email,
                      style: AppTextStyles.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        getTrendIcon(student.trend),
                        const SizedBox(width: 4),
                        Text(
                          '${student.completedModules}/${student.totalModules} modules',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: getPerformanceBgColor(student.overallScore),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      '${student.overallScore}%',
                      style: AppTextStyles.h3.copyWith(
                        color: getPerformanceColor(student.overallScore),
                      ),
                    ),
                    Text(
                      getPerformanceLabel(student.overallScore),
                      style: AppTextStyles.caption.copyWith(
                        color: getPerformanceColor(student.overallScore),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
