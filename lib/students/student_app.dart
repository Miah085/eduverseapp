import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Update imports to use package path
import 'package:eduverse/students/screens/home_dashboard_screen.dart';
import 'package:eduverse/students/screens/subjects_screen.dart';
import 'package:eduverse/students/screens/grades_screen.dart';
import 'package:eduverse/students/screens/profile_screen.dart';
import 'package:eduverse/students/screens/vr_entry_screen.dart';
import 'package:eduverse/students/screens/modules_screen.dart';
import 'package:eduverse/students/widgets/bottom_navigation.dart';
import 'package:eduverse/students/utils/app_colors.dart';

// Enum for internal student tabs
enum AppScreen { home, subjects, modules, grades, profile, vrEntry }

class StudentRootScreen extends StatefulWidget {
  const StudentRootScreen({super.key});

  @override
  State<StudentRootScreen> createState() => _StudentRootScreenState();
}

class _StudentRootScreenState extends State<StudentRootScreen> {
  AppScreen _currentScreen = AppScreen.home;

  void _navigateToScreen(AppScreen screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  Future<void> _handleLogout() async {
    // 1. Sign out from Supabase
    await Supabase.instance.client.auth.signOut();

    // 2. Redirect to Login via the Master Router
    if (mounted) {
      context.go('/login');
    }
  }

  // Logic to show Bottom Nav only on main tabs
  bool get _shouldShowBottomNav {
    return _currentScreen == AppScreen.home ||
        _currentScreen == AppScreen.subjects ||
        _currentScreen == AppScreen.grades ||
        _currentScreen == AppScreen.profile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          _buildCurrentScreen(),
          if (_shouldShowBottomNav)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavigation(
                currentScreen: _currentScreen,
                onNavigate: _navigateToScreen,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentScreen) {
      case AppScreen.home:
        return HomeDashboardScreen(
          // Pass navigation callback for internal student switching
          onNavigate: (screen) {
            if (screen is AppScreen) {
              _navigateToScreen(screen);
            }
          },
        );
      case AppScreen.subjects:
        return const SubjectsScreen();
      case AppScreen.modules:
        return ModulesScreen(onBack: () => _navigateToScreen(AppScreen.home));
      case AppScreen.grades:
        return const GradesScreen();
      case AppScreen.profile:
        return ProfileScreen(onLogout: _handleLogout);
      case AppScreen.vrEntry:
        return VREntryScreen(onBack: () => _navigateToScreen(AppScreen.home));
      default:
        return HomeDashboardScreen(
          onNavigate: (screen) {
            if (screen is AppScreen) {
              _navigateToScreen(screen);
            }
          },
        );
    }
  }
}
