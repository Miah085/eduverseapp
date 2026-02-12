import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/subjects_screen.dart';
import 'screens/grades_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/vr_entry_screen.dart';
import 'screens/modules_screen.dart';
import 'widgets/bottom_navigation.dart';
import 'utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const EduVerseApp());
}

class EduVerseApp extends StatelessWidget {
  const EduVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduVerse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: const AppNavigator(),
    );
  }
}

enum AppScreen {
  splash,
  login,
  register,
  home,
  subjects,
  modules,
  grades,
  profile,
  vrEntry,
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  AppScreen _currentScreen = AppScreen.splash;
  bool _isAuthenticated = false;

  void _navigateToScreen(AppScreen screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  void _handleLogin(String email) {
    setState(() {
      _isAuthenticated = true;
      _currentScreen = AppScreen.home;
    });
  }

  void _handleRegister() {
    setState(() {
      _isAuthenticated = true;
      _currentScreen = AppScreen.home;
    });
  }

  void _handleLogout() {
    setState(() {
      _isAuthenticated = false;
      _currentScreen = AppScreen.login;
    });
  }

  bool get _shouldShowBottomNav {
    return _isAuthenticated &&
        (_currentScreen == AppScreen.home ||
            _currentScreen == AppScreen.subjects ||
            _currentScreen == AppScreen.grades ||
            _currentScreen == AppScreen.profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      case AppScreen.splash:
        return SplashScreen(
          onComplete: () => _navigateToScreen(AppScreen.login),
        );
      case AppScreen.login:
        return LoginScreen(
          onLogin: _handleLogin,
          onNavigateToRegister: () => _navigateToScreen(AppScreen.register),
        );
      case AppScreen.register:
        return RegisterScreen(
          onRegister: _handleRegister,
          onNavigateToLogin: () => _navigateToScreen(AppScreen.login),
        );
      case AppScreen.home:
        return HomeDashboardScreen(
          onNavigate: _navigateToScreen,
        );
      case AppScreen.subjects:
        return const SubjectsScreen();
      case AppScreen.modules:
        return ModulesScreen(
          onBack: () => _navigateToScreen(AppScreen.home),
        );
      case AppScreen.grades:
        return const GradesScreen();
      case AppScreen.profile:
        return ProfileScreen(
          onLogout: _handleLogout,
        );
      case AppScreen.vrEntry:
        return VREntryScreen(
          onBack: () => _navigateToScreen(AppScreen.home),
        );
    }
  }
}
