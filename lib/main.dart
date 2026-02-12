import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

// Student Folder Imports
import 'package:eduverse/students/screens/splash_screen.dart';
import 'package:eduverse/students/screens/login_screen.dart';
import 'package:eduverse/students/screens/register_screen.dart';
import 'package:eduverse/students/student_app.dart';

// Teacher Folder Imports
import 'package:eduverse/teachers/screens/teacher_dashboard_screen.dart';
import 'package:eduverse/teachers/widgets/main_layout.dart';
import 'package:eduverse/teachers/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await Supabase.initialize(
    url: 'https://pjlbfxnmrsgprovoeczp.supabase.co',
    anonKey: 'sb_publishable_yq93ZtQqJyhSBt7NR3H8RQ_1X4V6nYI',
  );

  runApp(const EduVerseApp());
}

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

// Unified Navigation Logic: This checks your 'profiles' table to route correctly
Future<void> _handleNavigation(BuildContext context) async {
  final user = supabase.auth.currentUser;
  if (user == null) return;

  try {
    final response = await supabase
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .single();

    final role = response['role'] as String;

    // Direct to the appropriate sub-app folder based on the database role
    if (role == 'teacher') {
      context.go('/teacher-dashboard');
    } else {
      context.go('/student-home');
    }
  } catch (e) {
    // If no role is found, default to student for safety
    context.go('/student-home');
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(onComplete: () => context.go('/login')),
    ),
    // --- STUDENT LOGIN ---
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(
        isTeacher: false,
        onLogin: (email) => _handleNavigation(context),
        onNavigateToRegister: () => context.go('/register'),
      ),
    ),
    // --- TEACHER LOGIN ---
    GoRoute(
      path: '/teacher-login',
      builder: (context, state) => LoginScreen(
        isTeacher: true,
        onLogin: (email) => _handleNavigation(context),
        onNavigateToRegister: () => context.go('/register'),
      ),
    ),
    // --- SHARED REGISTRATION ---
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(
        // Triggers the role-check after account creation
        onRegister: () => _handleNavigation(context), 
        // Directs user back to their chosen role's login portal
        onNavigateToLogin: (isTeacher) => context.go(isTeacher ? '/teacher-login' : '/login'),
      ),
    ),
    // --- STUDENT DASHBOARD (Separate Folder) ---
    GoRoute(
      path: '/student-home', 
      builder: (context, state) => const StudentApp()
    ),
    // --- TEACHER DASHBOARD (Separate Folder) ---
    GoRoute(
      path: '/teacher-dashboard',
      builder: (context, state) => const MainLayout(
        currentIndex: 0, 
        child: TeacherDashboardScreen()
      ),
    ),
  ],
);