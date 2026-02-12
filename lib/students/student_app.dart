import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import 'screens/home_dashboard_screen.dart';
import 'screens/subjects_screen.dart';
import 'screens/modules_screen.dart';
import 'screens/grades_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/vr_entry_screen.dart';
import 'widgets/bottom_navigation.dart';
import 'utils/app_colors.dart';

enum AppScreen {
  home,
  subjects,
  modules,
  grades,
  profile,
  vrEntry,
}

class StudentApp extends StatefulWidget {
  const StudentApp({super.key}); // Ensure this constructor exists

  @override
  State<StudentApp> createState() => _StudentAppState();
}

class _StudentAppState extends State<StudentApp> {
  AppScreen _currentScreen = AppScreen.home; 

  void _navigateToScreen(AppScreen screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  void _handleLogout() async {
    await Supabase.instance.client.auth.signOut();
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool shouldShowBottomNav = [
      AppScreen.home,
      AppScreen.subjects,
      AppScreen.grades,
      AppScreen.profile
    ].contains(_currentScreen);

    return Scaffold(
      body: Stack(
        children: [
          _buildCurrentScreen(),
          if (shouldShowBottomNav)
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
        return HomeDashboardScreen(onNavigate: _navigateToScreen);
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
        return HomeDashboardScreen(onNavigate: _navigateToScreen);
    }
  }
}