import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/animated_card.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

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
              _buildHeader(context),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    _buildProfileInfo(),
                    const SizedBox(height: 24),
                    _buildStats(),
                    const SizedBox(height: 24),
                    _buildMenuItems(context),
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
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'AS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              )
                  .animate()
                  .scale(duration: 400.ms, curve: Curves.easeOut)
                  .fadeIn(),
              const SizedBox(height: 16),
              Text(
                'Andrea Sagum',
                style: AppTextStyles.h2.copyWith(color: Colors.white),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 4),
              Text(
                'History Teacher',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 4),
              Text(
                'andrea.sagum@eduverse.edu',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white.withOpacity(0.7),
                ),
              ).animate().fadeIn(delay: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedCard(
        delay: 100.ms,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About', style: AppTextStyles.h4),
            const SizedBox(height: 12),
            _buildInfoRow(LucideIcons.briefcase, 'Department', 'History'),
            const SizedBox(height: 12),
            _buildInfoRow(LucideIcons.calendar, 'Joined', 'September 2020'),
            const SizedBox(height: 12),
            _buildInfoRow(LucideIcons.award, 'Expertise', 'Ancient Civilizations'),
            const SizedBox(height: 12),
            _buildInfoRow(LucideIcons.mail, 'Email', 'andrea.sagum@eduverse.edu'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.gray500,
                ),
              ),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: AnimatedCard(
              delay: 200.ms,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    LucideIcons.bookOpen,
                    color: AppColors.primary,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '8',
                    style: AppTextStyles.h2.copyWith(color: AppColors.primary),
                  ),
                  Text('Modules', style: AppTextStyles.caption),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedCard(
              delay: 250.ms,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    LucideIcons.users,
                    color: AppColors.purple,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '42',
                    style: AppTextStyles.h2.copyWith(color: AppColors.purple),
                  ),
                  Text('Students', style: AppTextStyles.caption),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedCard(
              delay: 300.ms,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    LucideIcons.star,
                    color: AppColors.warning,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '4.8',
                    style: AppTextStyles.h2.copyWith(color: AppColors.warning),
                  ),
                  Text('Rating', style: AppTextStyles.caption),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final menuItems = [
      {
        'icon': LucideIcons.user,
        'title': 'Edit Profile',
        'subtitle': 'Update your information',
        'color': AppColors.primary,
      },
      {
        'icon': LucideIcons.bell,
        'title': 'Notifications',
        'subtitle': 'Manage notification settings',
        'color': AppColors.purple,
      },
      {
        'icon': LucideIcons.lock,
        'title': 'Privacy & Security',
        'subtitle': 'Password and security settings',
        'color': AppColors.cyan,
      },
      {
        'icon': LucideIcons.circleHelp,
        'title': 'Help & Support',
        'subtitle': 'Get help and contact support',
        'color': AppColors.success,
      },
      {
        'icon': LucideIcons.info,
        'title': 'About',
        'subtitle': 'App version and information',
        'color': AppColors.gray500,
      },
      {
        'icon': LucideIcons.logOut,
        'title': 'Logout',
        'subtitle': 'Sign out of your account',
        'color': AppColors.error,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          ...menuItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AnimatedCard(
                delay: (400 + index * 50).ms,
                child: InkWell(
                  onTap: () {
                    // Handle menu item tap
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: item['color'] as Color,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] as String,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                item['subtitle'] as String,
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          LucideIcons.chevronRight,
                          color: AppColors.gray400,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
