import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class GradeSubject {
  final String name;
  final int grade;
  final Color color;
  final String trend;

  GradeSubject({
    required this.name,
    required this.grade,
    required this.color,
    required this.trend,
  });
}

class Achievement {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Color iconColor;

  Achievement({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.iconColor,
  });
}

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _rotateController;
  late List<AnimationController> _gradeControllers;
  late List<AnimationController> _achievementControllers;

  final List<GradeSubject> subjects = [
    GradeSubject(
        name: 'Science', grade: 92, color: AppColors.cyan, trend: '+5'),
    GradeSubject(
        name: 'History', grade: 88, color: AppColors.purple, trend: '+3'),
    GradeSubject(
        name: 'Mathematics', grade: 85, color: AppColors.orange, trend: '+7'),
    GradeSubject(
        name: 'Literature', grade: 95, color: AppColors.pink, trend: '+2'),
    GradeSubject(
        name: 'Art & Design', grade: 78, color: AppColors.green, trend: '+4'),
    GradeSubject(name: 'Music', grade: 90, color: AppColors.red, trend: '+6'),
  ];

  final List<Achievement> achievements = [
    Achievement(
      title: 'Perfect Score',
      description: 'Achieved 100% in a module',
      icon: Icons.star,
      color: AppColors.accentYellow,
      iconColor: AppColors.orange,
    ),
    Achievement(
      title: 'Quick Learner',
      description: 'Completed 3 modules in a week',
      icon: Icons.auto_awesome,
      color: AppColors.accentLavender,
      iconColor: AppColors.purple,
    ),
    Achievement(
      title: '7 Day Streak',
      description: 'Studied for 7 consecutive days',
      icon: Icons.emoji_events,
      color: AppColors.accentBlue,
      iconColor: AppColors.primary,
    ),
  ];

  int get overallGrade =>
      (subjects.fold(0, (sum, s) => sum + s.grade) / subjects.length).round();

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _gradeControllers = List.generate(
      subjects.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
      ),
    );

    _achievementControllers = List.generate(
      achievements.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      for (var i = 0; i < _gradeControllers.length; i++) {
        Future.delayed(Duration(milliseconds: i * 100), () {
          if (mounted) _gradeControllers[i].forward();
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      for (var i = 0; i < _achievementControllers.length; i++) {
        Future.delayed(Duration(milliseconds: i * 100), () {
          if (mounted) _achievementControllers[i].forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _rotateController.dispose();
    for (var controller in _gradeControllers) {
      controller.dispose();
    }
    for (var controller in _achievementControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.white, AppColors.gray50],
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _headerController,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Progress',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Overall Grade',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.white.withOpacity(0.8),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '$overallGrade',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '%',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: AppColors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.trending_up,
                                      size: 16,
                                      color: AppColors.green,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "You're doing great!",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _rotateController,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _rotateController.value * 0.2 - 0.1,
                                child: Transform.scale(
                                  scale: 1.0 + (_rotateController.value * 0.1),
                                  child: Container(
                                    width: 96,
                                    height: 96,
                                    decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.black,
                                          blurRadius: 16,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.emoji_events,
                                      size: 48,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  '6',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Subjects',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  '12',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Completed',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'A',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Grade Level',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  'Subject Grades',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gray800,
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(subjects.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildGradeCard(subjects[index], index),
                  );
                }),
                const SizedBox(height: 32),
                const Text(
                  'Recent Achievements',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gray800,
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(achievements.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildAchievementCard(achievements[index], index),
                  );
                }),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeCard(GradeSubject subject, int index) {
    return AnimatedBuilder(
      animation: _gradeControllers[index],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(-20 * (1 - _gradeControllers[index].value), 0),
          child: Opacity(
            opacity: _gradeControllers[index].value,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: subject.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            subject.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray800,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.trending_up,
                                size: 12,
                                color: AppColors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                subject.trend,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${subject.grade}%',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.gray800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (subject.grade / 100) *
                          _gradeControllers[index].value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: subject.color,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAchievementCard(Achievement achievement, int index) {
    return AnimatedBuilder(
      animation: _achievementControllers[index],
      builder: (context, child) {
        return Transform.scale(
          scale: 0.95 + (0.05 * _achievementControllers[index].value),
          child: Opacity(
            opacity: _achievementControllers[index].value,
            child: Container(
              decoration: BoxDecoration(
                color: achievement.color,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      achievement.icon,
                      size: 24,
                      color: achievement.iconColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          achievement.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.gray600,
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
      },
    );
  }
}
