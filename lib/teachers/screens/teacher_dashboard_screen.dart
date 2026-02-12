import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/stat_card.dart';
import '../widgets/animated_card.dart';
import '../widgets/gradient_avatar.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});
  
  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  final List<Map<String, dynamic>> stats = [
    {
      'label': 'Active Modules',
      'value': '8',
      'icon': LucideIcons.bookOpen,
      'backgroundColor': AppColors.primaryLight,
      'iconColor': AppColors.primary,
    },
    {
      'label': 'Total Students',
      'value': '42',
      'icon': LucideIcons.users,
      'backgroundColor': AppColors.purpleLight,
      'iconColor': AppColors.purple,
    },
    {
      'label': 'Pending Reviews',
      'value': '15',
      'icon': LucideIcons.clock,
      'backgroundColor': AppColors.yellow,
      'iconColor': AppColors.orange,
    },
    {
      'label': 'Completion Rate',
      'value': '87%',
      'icon': LucideIcons.trendingUp,
      'backgroundColor': AppColors.successLight,
      'iconColor': AppColors.success,
    },
  ];
  
  final List<Map<String, dynamic>> quickActions = [
    {
      'title': 'Create Module',
      'icon': LucideIcons.bookOpen,
      'color': AppColors.primary,
      'route': '/teacher-modules',
    },
    {
      'title': 'Upload Lesson',
      'icon': LucideIcons.fileText,
      'color': AppColors.purple,
      'route': '/teacher-create-lesson',
    },
    {
      'title': 'Create Assignment',
      'icon': LucideIcons.check,
      'color': AppColors.cyan,
      'route': '/teacher-create-assignment',
    },
    {
      'title': 'VR Sessions',
      'icon': LucideIcons.settings,
      'color': AppColors.orange,
      'route': '/teacher-vr-management',
    },
  ];
  
  final List<Map<String, String>> recentActivity = [
    {
      'student': 'Jett',
      'action': 'submitted assignment',
      'item': 'Egypt Presentation',
      'time': '5 min ago',
      'avatar': 'J',
    },
    {
      'student': 'Phoenix',
      'action': 'completed quiz',
      'item': 'Ancient Greece Quiz',
      'time': '12 min ago',
      'avatar': 'P',
    },
    {
      'student': 'Sage',
      'action': 'started module',
      'item': 'Roman Empire',
      'time': '1 hour ago',
      'avatar': 'S',
    },
  ];
  
  final List<Map<String, dynamic>> upcomingDeadlines = [
    {
      'assignment': 'Greece vs Rome Essay',
      'dueDate': 'Feb 10',
      'submissions': 28,
      'total': 42,
    },
    {
      'assignment': 'Ancient China Quiz',
      'dueDate': 'Feb 12',
      'submissions': 35,
      'total': 42,
    },
    {
      'assignment': 'Renaissance Project',
      'dueDate': 'Feb 15',
      'submissions': 12,
      'total': 42,
    },
  ];
  
  final List<Map<String, dynamic>> subjectPerformanceData = [
    {'subject': 'Ancient Greece', 'score': 88.0},
    {'subject': 'Roman Empire', 'score': 82.0},
    {'subject': 'Renaissance', 'score': 75.0},
    {'subject': 'Ancient Egypt', 'score': 71.0},
    {'subject': 'Ancient China', 'score': 66.0},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              // Header
              _buildHeader(),
              
              // Content
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildAnalyticsSection(),
                    const SizedBox(height: 24),
                    _buildQuickActions(),
                    const SizedBox(height: 24),
                    _buildRecentActivity(),
                    const SizedBox(height: 24),
                    _buildUpcomingDeadlines(),
                    const SizedBox(height: 100), // Bottom padding for nav bar
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, Andrea Sagum! ',
                          style: AppTextStyles.h2.copyWith(color: Colors.white),
                        )
                            .animate(onPlay: (controller) => controller.repeat())
                            .shimmer(duration: 2000.ms, delay: 3000.ms),
                        const SizedBox(height: 4),
                        Text(
                          'Manage your classes and content',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go('/profile');
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: AppColors.warningGradient,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              'PS',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.gray800,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ).animate().scale(delay: 200.ms),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Stats Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: stats.length,
                itemBuilder: (context, index) {
                  final stat = stats[index];
                  return StatCard(
                    label: stat['label'],
                    value: stat['value'],
                    icon: stat['icon'],
                    backgroundColor: stat['backgroundColor'],
                    iconColor: stat['iconColor'],
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildAnalyticsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Analytics Overview', style: AppTextStyles.h4),
              TextButton.icon(
                onPressed: () {
                  context.go('/teacher-students');
                },
                icon: const Icon(LucideIcons.users, size: 16),
                label: Text(
                  'View Students',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Class Performance Card
          AnimatedCard(
            delay: 200.ms,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      LucideIcons.chartBar,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text('Class Performance', style: AppTextStyles.h4),
                  ],
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              LucideIcons.users,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text('42', style: AppTextStyles.h2),
                            Text(
                              'Total Students',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.purpleLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              LucideIcons.trendingUp,
                              color: AppColors.purple,
                              size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text('78.5%', style: AppTextStyles.h2),
                            Text(
                              'Avg Performance',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Performance Highlights
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.award,
                        color: AppColors.success,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Highest Performance',
                              style: AppTextStyles.caption,
                            ),
                            Text(
                              'Ancient Greece',
                              style: AppTextStyles.h4,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '88.2% average',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 12),
                
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.warningLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.circleAlert,
                        color: AppColors.warning,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Needs Attention',
                              style: AppTextStyles.caption,
                            ),
                            Text(
                              'Ancient China',
                              style: AppTextStyles.h4,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '65.8% average',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.warning,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Performance Chart
          AnimatedCard(
            delay: 300.ms,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subject Performance Overview',
                  style: AppTextStyles.h4,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 100,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const subjects = [
                                'Greece',
                                'Roman',
                                'Renais.',
                                'Egypt',
                                'China',
                              ];
                              if (value.toInt() >= 0 &&
                                  value.toInt() < subjects.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    subjects[value.toInt()],
                                    style: AppTextStyles.caption,
                                  ),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '${value.toInt()}',
                                style: AppTextStyles.caption,
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: AppColors.gray200,
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          );
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(
                        subjectPerformanceData.length,
                        (index) {
                          final score = subjectPerformanceData[index]['score'];
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: score,
                                color: AppColors.primary,
                                width: 20,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem('80-100: Strong', AppColors.success),
                    const SizedBox(width: 16),
                    _buildLegendItem('60-79: Moderate', AppColors.warning),
                    const SizedBox(width: 16),
                    _buildLegendItem('<60: Needs Help', AppColors.error),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
  
  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: quickActions.length,
            itemBuilder: (context, index) {
              final action = quickActions[index];
              return GestureDetector(
                onTap: () {
                  context.go(action['route']);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: action['color'],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (action['color'] as Color).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        action['icon'],
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        action['title'],
                        style: AppTextStyles.labelMedium.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: (400 + index * 100).ms)
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      duration: 400.ms,
                      delay: (400 + index * 100).ms,
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildRecentActivity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Activity', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          AnimatedCard(
            padding: const EdgeInsets.all(16),
            delay: 700.ms,
            child: Column(
              children: [
                ...recentActivity.asMap().entries.map((entry) {
                  final index = entry.key;
                  final activity = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index < recentActivity.length - 1 ? 12 : 0,
                    ),
                    child: Row(
                      children: [
                        GradientAvatar(
                          text: activity['avatar']!,
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: activity['student'],
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.gray800,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ${activity['action']}',
                                      style: AppTextStyles.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                activity['item']!,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          activity['time']!,
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All Submissions →',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildUpcomingDeadlines() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming Deadlines', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          ...upcomingDeadlines.asMap().entries.map((entry) {
            final index = entry.key;
            final deadline = entry.value;
            final progress = (deadline['submissions'] / deadline['total']) * 100;
            
            Color progressColor;
            if (progress >= 80) {
              progressColor = AppColors.success;
            } else if (progress >= 50) {
              progressColor = AppColors.warning;
            } else {
              progressColor = AppColors.error;
            }
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AnimatedCard(
                delay: (1000 + index * 100).ms,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deadline['assignment'],
                                style: AppTextStyles.h4,
                              ),
                              Text(
                                'Due: ${deadline['dueDate']}, 2026',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${deadline['submissions']}/${deadline['total']}',
                              style: AppTextStyles.h4.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              'Submitted',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress / 100,
                        minHeight: 8,
                        backgroundColor: AppColors.gray200,
                        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
