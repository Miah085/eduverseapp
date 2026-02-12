import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/animated_card.dart';

class TeacherModulesScreen extends StatefulWidget {
  const TeacherModulesScreen({super.key});
  
  @override
  State<TeacherModulesScreen> createState() => _TeacherModulesScreenState();
}

class _TeacherModulesScreenState extends State<TeacherModulesScreen> {
  String activeFilter = 'all';
  
  final List<Map<String, dynamic>> modules = [
    {
      'id': 1,
      'title': 'Introduction to Ancient Civilizations',
      'subject': 'History',
      'status': 'active',
      'students': 42,
      'lessons': 8,
      'lastUpdated': 'Feb 5, 2026',
      'color': AppColors.primary,
    },
    {
      'id': 2,
      'title': 'The Renaissance Period',
      'subject': 'History',
      'status': 'active',
      'students': 38,
      'lessons': 6,
      'lastUpdated': 'Feb 4, 2026',
      'color': AppColors.purple,
    },
    {
      'id': 3,
      'title': 'World War II Analysis',
      'subject': 'History',
      'status': 'active',
      'students': 40,
      'lessons': 10,
      'lastUpdated': 'Feb 3, 2026',
      'color': AppColors.cyan,
    },
    {
      'id': 4,
      'title': 'Medieval Europe',
      'subject': 'History',
      'status': 'archived',
      'students': 35,
      'lessons': 7,
      'lastUpdated': 'Jan 28, 2026',
      'color': AppColors.gray400,
    },
  ];
  
  List<Map<String, dynamic>> get filteredModules {
    if (activeFilter == 'all') return modules;
    return modules.where((m) => m['status'] == activeFilter).toList();
  }
  
  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: filteredModules.length,
                  itemBuilder: (context, index) {
                    return _buildModuleCard(filteredModules[index], index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(LucideIcons.plus, color: Colors.white),
      )
          .animate()
          .scale(duration: 500.ms, delay: 500.ms, curve: Curves.elasticOut),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
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
                Expanded(
                  child: Text(
                    'Module Management',
                    style: AppTextStyles.h3.copyWith(color: Colors.white),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    LucideIcons.plus,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildFilterTab('all', 'All'),
                const SizedBox(width: 8),
                _buildFilterTab('active', 'Active'),
                const SizedBox(width: 8),
                _buildFilterTab('archived', 'Archived'),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: -0.2, end: 0);
  }
  
  Widget _buildFilterTab(String key, String label) {
    final isActive = activeFilter == key;
    return GestureDetector(
      onTap: () => setState(() => activeFilter = key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isActive ? AppColors.primary : Colors.white,
          ),
        ),
      ),
    );
  }
  
  Widget _buildModuleCard(Map<String, dynamic> module, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AnimatedCard(
        padding: EdgeInsets.zero,
        delay: (index * 100).ms,
        child: Column(
          children: [
            // Module Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: module['color'],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module['title'],
                          style: AppTextStyles.h4.copyWith(color: Colors.white),
                        ),
                        Text(
                          module['subject'],
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: module['status'] == 'active'
                          ? AppColors.successLight
                          : AppColors.gray100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      module['status'] == 'active' ? 'Active' : 'Archived',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: module['status'] == 'active'
                            ? AppColors.success
                            : AppColors.gray700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Module Stats
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Icon(
                              LucideIcons.users,
                              color: AppColors.gray500,
                              size: 16,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${module['students']}',
                              style: AppTextStyles.h4,
                            ),
                            Text(
                              'Students',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Icon(
                              LucideIcons.fileText,
                              color: AppColors.gray500,
                              size: 16,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${module['lessons']}',
                              style: AppTextStyles.h4,
                            ),
                            Text(
                              'Lessons',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Updated',
                              style: AppTextStyles.caption,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              module['lastUpdated'],
                              style: AppTextStyles.labelSmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.go('/teacher-create-lesson');
                          },
                          icon: const Icon(LucideIcons.pen, size: 16),
                          label: const Text('Edit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryLight,
                            foregroundColor: AppColors.primary,
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(LucideIcons.eye, size: 16),
                          label: const Text('View'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purpleLight,
                            foregroundColor: AppColors.purple,
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gray100,
                          foregroundColor: AppColors.gray600,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: const Icon(LucideIcons.archive, size: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}