import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

// Student Imports
import 'package:eduverse/students/screens/splash_screen.dart';
import 'package:eduverse/students/screens/login_screen.dart';
import 'package:eduverse/students/screens/register_screen.dart';
import 'package:eduverse/students/screens/home_dashboard_screen.dart';

// Teacher Imports
import 'package:eduverse/teachers/screens/teacher_dashboard_screen.dart';
import 'package:eduverse/teachers/widgets/main_layout.dart';
import 'package:eduverse/teachers/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Custom status bar styling
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Initializing Supabase with your credentials
  await Supabase.initialize(
    url: 'https://pjlbfxnmrsgprovoeczp.supabase.co',
    anonKey: 'sb_publishable_yq93ZtQqJyhSBt7NR3H8RQ_1X4V6nYI',
  );

  runApp(const EduVerseApp());
}

// Global Supabase client for easy access
final supabase = Supabase.instance.client;

class EduVerseApp extends StatelessWidget {
  const EduVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EduVerse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, 
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(
        onComplete: () => context.go('/login'),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(
        onLogin: (email) => _handleNavigation(context),
        onNavigateToRegister: () => context.go('/register'),
      ),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(
        onRegister: () => _handleNavigation(context),
        onNavigateToLogin: () => context.go('/login'),
      ),
    ),
    // Route for Students
    GoRoute(
      path: '/student-home',
      builder: (context, state) => HomeDashboardScreen(
        onNavigate: (screen) {
          // Internal student navigation logic
        },
      ),
    ),
    // Route for Teachers
    GoRoute(
      path: '/teacher-dashboard',
      builder: (context, state) => const MainLayout(
        currentIndex: 0,
        child: TeacherDashboardScreen(),
      ),
    ),
  ],
);

// Unified Navigation Logic: Checks database for role
Future<void> _handleNavigation(BuildContext context) async {
  final user = supabase.auth.currentUser;
  if (user == null) return;

  try {
    // Queries the 'profiles' table you created in Supabase
    final response = await supabase
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .single();

    final role = response['role'] as String;

    if (role == 'teacher') {
      context.go('/teacher-dashboard');
    } else {
      context.go('/student-home');
    }
  } catch (e) {
    // If the role check fails, we default to student side
    context.go('/student-home');
  }
}