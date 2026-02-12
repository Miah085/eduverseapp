import 'package:flutter/material.dart';
import 'package:eduverse/students/utils/app_colors.dart';
import 'package:eduverse/students/student_app.dart'; // Corrected Import

class BottomNavigation extends StatefulWidget {
  final AppScreen currentScreen;
  final Function(AppScreen) onNavigate;

  const BottomNavigation({
    super.key,
    required this.currentScreen,
    required this.onNavigate,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'screen': AppScreen.home, 'label': 'Home', 'icon': Icons.home_rounded},
      {'screen': AppScreen.subjects, 'label': 'Subjects', 'icon': Icons.menu_book_rounded},
      {'screen': AppScreen.grades, 'label': 'Grades', 'icon': Icons.emoji_events_rounded},
      {'screen': AppScreen.profile, 'label': 'Profile', 'icon': Icons.person_rounded},
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          final screen = item['screen'] as AppScreen;
          final isSelected = widget.currentScreen == screen;

          return GestureDetector(
            onTap: () => widget.onNavigate(screen),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: isSelected ? AppColors.primary : AppColors.gray400,
                    size: 24,
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    Text(
                      item['label'] as String,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}