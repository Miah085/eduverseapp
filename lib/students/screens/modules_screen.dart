import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../main.dart';
// IMPORT THE NEW SCREEN HERE
import 'module_detail_screen.dart';

class ModulesScreen extends StatefulWidget {
  final VoidCallback onBack;

  const ModulesScreen({super.key, required this.onBack});

  @override
  State<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _progressController;
  late List<AnimationController> _moduleControllers;

  final List<ModuleData> modules = [
    ModuleData(
      title: 'Introduction to Ancient Egypt',
      status: ModuleStatus.completed,
      duration: '45 min',
      progress: 100,
      lessons: 6,
    ),
    ModuleData(
      title: 'The Pyramids Mystery',
      status: ModuleStatus.completed,
      duration: '60 min',
      progress: 100,
      lessons: 8,
    ),
    ModuleData(
      title: 'Ancient Civilizations',
      status: ModuleStatus.inProgress,
      duration: '50 min',
      progress: 75,
      lessons: 7,
    ),
    ModuleData(
      title: 'Greek Mythology',
      status: ModuleStatus.available,
      duration: '55 min',
      progress: 0,
      lessons: 9,
    ),
    ModuleData(
      title: 'Roman Empire',
      status: ModuleStatus.locked,
      duration: '70 min',
      progress: 0,
      lessons: 10,
    ),
    ModuleData(
      title: 'Medieval Times',
      status: ModuleStatus.locked,
      duration: '65 min',
      progress: 0,
      lessons: 8,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _moduleControllers = List.generate(
      modules.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      ),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _progressController.forward();
    });

    for (var i = 0; i < _moduleControllers.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        if (mounted) _moduleControllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    _headerController.dispose();
    _progressController.dispose();
    for (var controller in _moduleControllers) {
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
          colors: [AppColors.white, Color(0xFFF3F0FF)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 120),
          children: [
            FadeTransition(
              opacity: _headerController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.2),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _headerController,
                  curve: Curves.easeOut,
                )),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.purple, AppColors.purpleDark],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.purple.withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: widget.onBack,
                        icon: const Icon(Icons.arrow_back,
                            color: AppColors.white),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'History Course',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Learning Modules',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Course Progress',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.white,
                                  ),
                                ),
                                Text(
                                  '45%',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: AnimatedBuilder(
                                animation: _progressController,
                                builder: (context, child) {
                                  return FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor:
                                        0.45 * _progressController.value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.white
                                                .withOpacity(0.5),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Text(
                'All Modules',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gray800,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(modules.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                child: _buildModuleCard(modules[index], index),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard(ModuleData module, int index) {
    return AnimatedBuilder(
      animation: _moduleControllers[index],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(-20 * (1 - _moduleControllers[index].value), 0),
          child: Opacity(
            opacity: _moduleControllers[index].value,
            child: GestureDetector(
              // NAVIGATION LOGIC ADDED HERE
              onTap: module.status != ModuleStatus.locked
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModuleDetailScreen(
                            moduleName: module.title,
                            onBack: () => Navigator.pop(context),
                          ),
                        ),
                      );
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: _getBackgroundColor(module.status),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _getBorderColor(module.status),
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: _getStatusIcon(module.status),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            module.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: module.status == ModuleStatus.locked
                                  ? AppColors.gray500
                                  : AppColors.gray800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '${module.lessons} lessons',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.gray600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '•',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.gray600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                module.duration,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.gray600,
                                ),
                              ),
                            ],
                          ),
                          if (module.status != ModuleStatus.locked &&
                              module.progress > 0) ...[
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: AppColors.gray200,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: (module.progress / 100) *
                                          _moduleControllers[index].value,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: module.status ==
                                                  ModuleStatus.completed
                                              ? AppColors.green
                                              : AppColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: 48,
                                  child: Text(
                                    '${module.progress}%',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.gray700,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (module.status == ModuleStatus.locked) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.gray200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.lock,
                                    size: 12,
                                    color: AppColors.gray600,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Complete previous modules',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.gray600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getStatusIcon(ModuleStatus status) {
    switch (status) {
      case ModuleStatus.completed:
        return const Icon(
          Icons.check_circle,
          size: 24,
          color: AppColors.green,
        );
      case ModuleStatus.inProgress:
        return const Icon(
          Icons.play_circle_filled,
          size: 24,
          color: AppColors.primary,
        );
      case ModuleStatus.locked:
        return const Icon(
          Icons.lock,
          size: 24,
          color: AppColors.gray400,
        );
      default:
        return const Icon(
          Icons.circle_outlined,
          size: 24,
          color: AppColors.gray400,
        );
    }
  }

  Color _getBackgroundColor(ModuleStatus status) {
    switch (status) {
      case ModuleStatus.completed:
        return AppColors.greenLight;
      case ModuleStatus.inProgress:
        return AppColors.accentBlue;
      case ModuleStatus.locked:
        return AppColors.gray50;
      default:
        return AppColors.white;
    }
  }

  Color _getBorderColor(ModuleStatus status) {
    switch (status) {
      case ModuleStatus.completed:
        return AppColors.green;
      case ModuleStatus.inProgress:
        return AppColors.primary;
      case ModuleStatus.locked:
        return AppColors.gray200;
      default:
        return AppColors.gray200;
    }
  }
}

enum ModuleStatus {
  completed,
  inProgress,
  available,
  locked,
}

class ModuleData {
  final String title;
  final ModuleStatus status;
  final String duration;
  final int progress;
  final int lessons;

  ModuleData({
    required this.title,
    required this.status,
    required this.duration,
    required this.progress,
    required this.lessons,
  });
}
