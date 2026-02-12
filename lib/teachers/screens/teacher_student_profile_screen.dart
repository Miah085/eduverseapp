import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/animated_card.dart';
import '../widgets/gradient_avatar.dart';
import '../models/student.dart'; // Imports your actual student model

// Define these helper classes locally so we don't break your student.dart
enum StudentTrend { up, down, stable }

class SubjectPerformance {
  final String name;
  final double avgScore;
  final int progress;
  final StudentTrend trend;

  SubjectPerformance({
    required this.name,
    required this.avgScore,
    required this.progress,
    required this.trend,
  });
}

class TeacherStudentProfileScreen extends StatelessWidget {
  final Student student;

  const TeacherStudentProfileScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    // MOCK DATA: Since your Student model doesn't store grades/subjects yet,
    // we generate fake data here so the charts render correctly.
    final subjects = [
      SubjectPerformance(name: 'Math', avgScore: 85, progress: 80, trend: StudentTrend.up),
      SubjectPerformance(name: 'Science', avgScore: 72, progress: 65, trend: StudentTrend.stable),
      SubjectPerformance(name: 'History', avgScore: 90, progress: 95, trend: StudentTrend.up),
      SubjectPerformance(name: 'Art', avgScore: 88, progress: 70, trend: StudentTrend.down),
    ];

    // Calculate a mock overall score
    final double overallScore = subjects.map((e) => e.avgScore).reduce((a, b) => a + b) / subjects.length;

    final strongSubjects = subjects.where((s) => s.avgScore >= 80).toList();
    final needsImprovement = subjects.where((s) => s.avgScore < 75).toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              _buildHeader(context),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildActivityStats(context, overallScore),
                    const SizedBox(height: 24),
                    _buildPerformanceChart(context, subjects),
                    const SizedBox(height: 24),
                    _buildPerformanceAnalysis(context, strongSubjects, needsImprovement),
                    const SizedBox(height: 24),
                    _buildSubjectBreakdown(context, subjects),
                    const SizedBox(height: 24),
                    _buildQuickActions(context),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
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
                    onTap: () => Navigator.pop(context),
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
                  Text(
                    'Student Profile',
                    style: AppTextStyles.h3.copyWith(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Student Overview Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    GradientAvatar(
                      text: student.initials, // Uses the getter from your model
                      size: 64,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student.name, style: AppTextStyles.h3),
                          Text(
                            'ID: #${student.id}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.gray600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: student.isActive ? AppColors.successLight : AppColors.errorLight,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              student.status.toUpperCase(),
                              style: AppTextStyles.caption.copyWith(
                                color: student.isActive ? AppColors.success : AppColors.error,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 100.ms).scale(delay: 100.ms),
            ],
          ),
        ),
      ).animate().fadeIn().slideY(begin: -0.2, end: 0),
    );
  }

  Widget _buildActivityStats(BuildContext context, double overallScore) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activity Statistics', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          AnimatedCard(
            delay: 200.ms,
            child: Row(
              children: [
                Expanded(
                  child: _statItem(
                    icon: LucideIcons.bookOpen,
                    color: AppColors.primary,
                    bgColor: AppColors.primaryLight,
                    value: '${student.completedModules}/${student.totalModules}',
                    label: 'Modules',
                  ),
                ),
                Expanded(
                  child: _statItem(
                    icon: LucideIcons.award,
                    color: AppColors.purple,
                    bgColor: AppColors.purpleLight,
                    value: '${overallScore.toInt()}%',
                    label: 'Avg Grade',
                  ),
                ),
                Expanded(
                  child: _statItem(
                    icon: LucideIcons.chartBar,
                    color: AppColors.orange,
                    bgColor: AppColors.yellow,
                    // Use the actual progress from your student model
                    value: '${(student.progress * 100).toInt()}%', 
                    label: 'Progress',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem({
    required IconData icon,
    required Color color,
    required Color bgColor,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(value, style: AppTextStyles.h2),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }

  Widget _buildPerformanceChart(BuildContext context, List<SubjectPerformance> subjects) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Subject Performance', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          AnimatedCard(
            delay: 300.ms,
            child: SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barGroups: subjects.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: data.avgScore,
                          color: data.avgScore >= 80 ? AppColors.success : AppColors.primary,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceAnalysis(
    BuildContext context,
    List<SubjectPerformance> strong,
    List<SubjectPerformance> weak,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          if (strong.isNotEmpty)
            AnimatedCard(
              delay: 400.ms,
              child: ListTile(
                leading: const Icon(LucideIcons.award, color: AppColors.success),
                title: const Text('Strong Performance'),
                subtitle: Text(strong.map((e) => e.name).join(', ')),
              ),
            ),
          if (weak.isNotEmpty) ...[
            const SizedBox(height: 12),
            AnimatedCard(
              delay: 450.ms,
              child: ListTile(
                leading: const Icon(LucideIcons.triangleAlert, color: AppColors.warning),
                title: const Text('Needs Attention'),
                subtitle: Text(weak.map((e) => e.name).join(', ')),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildSubjectBreakdown(BuildContext context, List<SubjectPerformance> subjects) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Subject Breakdown', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          ...subjects.map((s) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AnimatedCard(
              child: ListTile(
                title: Text(s.name, style: AppTextStyles.bodyMedium),
                trailing: Text('${s.avgScore.toInt()}%', style: AppTextStyles.h4),
                subtitle: LinearProgressIndicator(
                  value: s.progress / 100,
                  backgroundColor: AppColors.gray200,
                  valueColor: AlwaysStoppedAnimation(
                    s.avgScore >= 80 ? AppColors.success : AppColors.primary,
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedCard(
        delay: 600.ms,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(LucideIcons.mail, color: AppColors.primary),
              title: const Text('Send Message'),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () {},
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(LucideIcons.fileText, color: AppColors.purple),
              title: const Text('Generate Report'),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}