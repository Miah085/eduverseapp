import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../main.dart';

class BottomNavigation extends StatefulWidget {
  final AppScreen currentScreen;
  final Function(AppScreen) onNavigate;

  const BottomNavigation(
      {super.key, required this.currentScreen, required this.onNavigate});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {'screen': AppScreen.home, 'label': 'Home', 'icon': Icons.home},
      {
        'screen': AppScreen.subjects,
        'label': 'Subjects',
        'icon': Icons.menu_book
      },
      {
        'screen': AppScreen.grades,
        'label': 'Grades',
        'icon': Icons.emoji_events
      },
      {'screen': AppScreen.profile, 'label': 'Profile', 'icon': Icons.person},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border:
            const Border(top: BorderSide(color: AppColors.gray200, width: 1)),
        boxShadow: [
          BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, -2))
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navItems.map((item) {
              final screen = item['screen'] as AppScreen;
              final isActive = widget.currentScreen == screen;
              return _buildNavItem(
                  item['label'] as String,
                  item['icon'] as IconData,
                  isActive,
                  () => widget.onNavigate(screen));
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      String label, IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isActive)
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2)),
              ),
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                if (isActive)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16)),
                  ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                          0, isActive ? -3 * _animationController.value : 0),
                      child: Icon(icon,
                          size: 24,
                          color:
                              isActive ? AppColors.primary : AppColors.gray400),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? AppColors.primary : AppColors.gray400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
