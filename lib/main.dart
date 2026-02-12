import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

// Model and Screen Imports
import 'package:eduverse/teachers/models/student.dart';
import 'package:eduverse/students/screens/splash_screen.dart';
import 'package:eduverse/students/screens/login_screen.dart';
import 'package:eduverse/students/screens/register_screen.dart';
import 'package:eduverse/students/screens/modules_screen.dart' as student_screens;
import 'package:eduverse/students/screens/module_detail_screen.dart';
import 'package:eduverse/students/screens/subjects_screen.dart';
import 'package:eduverse/students/screens/subject_detail_screen.dart';
import 'package:eduverse/students/screens/grades_screen.dart';
import 'package:eduverse/students/screens/profile_screen.dart' as student_profile;
import 'package:eduverse/students/screens/vr_entry_screen.dart';
import 'package:eduverse/students/student_app.dart';

import 'package:eduverse/teachers/screens/teacher_dashboard_screen.dart';
import 'package:eduverse/teachers/screens/teacher_modules_screen.dart';
import 'package:eduverse/teachers/screens/teacher_students_screen.dart';
import 'package:eduverse/teachers/screens/teacher_profile_screen.dart';
import 'package:eduverse/teachers/screens/teacher_vr_management_screen.dart';
import 'package:eduverse/teachers/screens/teacher_create_lesson_screen.dart';
import 'package:eduverse/teachers/screens/teacher_create_assignment_screen.dart';
import 'package:eduverse/teachers/screens/teacher_student_profile_screen.dart';
import 'package:eduverse/teachers/widgets/main_layout.dart';
import 'package:eduverse/teachers/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
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

Future<void> _handleNavigation(BuildContext context) async {
  final user = supabase.auth.currentUser;
  if (user == null) return;
  try {
    final response = await supabase.from('profiles').select('role').eq('id', user.id).single();
    final String role = response['role'] as String;
    // Use go() to reset the stack for a fresh dashboard start
    context.go(role == 'teacher' ? '/teacher-dashboard' : '/student-home');
  } catch (e) {
    context.go('/student-home');
  }
}

// HELPER: Safely navigate back or return home if stack is empty
void _safePop(BuildContext context, String fallbackPath) {
  if (GoRouter.of(context).canPop()) {
    context.pop();
  } else {
    context.go(fallbackPath);
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: ElevatedButton(
        onPressed: () => context.go('/splash'),
        child: const Text('Navigation Error: Return to Splash'),
      ),
    ),
  ),
  routes: [
    // --- AUTH ---
    GoRoute(path: '/splash', builder: (context, state) => SplashScreen(onComplete: () => context.go('/login'))),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen(isTeacher: false, onLogin: (email) => _handleNavigation(context), onNavigateToRegister: () => context.go('/register'))),
    GoRoute(path: '/teacher-login', builder: (context, state) => LoginScreen(isTeacher: true, onLogin: (email) => _handleNavigation(context), onNavigateToRegister: () => context.go('/register'))),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen(onRegister: () => _handleNavigation(context), onNavigateToLogin: (isTeacher) => context.go(isTeacher ? '/teacher-login' : '/login'))),

    // --- STUDENT ROUTES ---
    GoRoute(path: '/student-home', builder: (context, state) => const StudentApp()),
    GoRoute(path: '/student-modules', builder: (context, state) => student_screens.ModulesScreen(onBack: () => context.go('/student-home'))),
    GoRoute(path: '/student-module-detail', builder: (context, state) => ModuleDetailScreen(moduleName: state.extra as String? ?? 'Module', onBack: () => _safePop(context, '/student-home'))),
    GoRoute(path: '/student-subjects', builder: (context, state) => const SubjectsScreen()),
    GoRoute(path: '/student-subject-detail', builder: (context, state) {
      final args = state.extra as Map<String, dynamic>? ?? {};
      return SubjectDetailScreen(
        subjectName: args['subjectName'] ?? 'Subject',
        image: args['image'] ?? '',
        moduleCount: args['moduleCount'] ?? 0,
        duration: args['duration'] ?? '',
        progress: args['progress'] ?? 0.0,
      );
    }),
    GoRoute(path: '/student-grades', builder: (context, state) => const GradesScreen()),
    GoRoute(path: '/student-profile', builder: (context, state) => student_profile.ProfileScreen(onLogout: () async {
      await supabase.auth.signOut();
      context.go('/login');
    })),
    GoRoute(path: '/student-vr-entry', builder: (context, state) => VREntryScreen(onBack: () => _safePop(context, '/student-home'))),

    // --- TEACHER ROUTES ---
    GoRoute(path: '/teacher-dashboard', builder: (context, state) => const MainLayout(currentIndex: 0, child: TeacherDashboardScreen())),
    GoRoute(path: '/teacher-modules', builder: (context, state) => const MainLayout(currentIndex: 1, child: TeacherModulesScreen())),
    GoRoute(path: '/teacher-students', builder: (context, state) => const MainLayout(currentIndex: 2, child: TeacherStudentsScreen())),
    GoRoute(path: '/teacher-vr-management', builder: (context, state) => const MainLayout(currentIndex: 3, child: TeacherVRManagementScreen())),
    GoRoute(path: '/teacher-profile', builder: (context, state) => const MainLayout(currentIndex: 4, child: TeacherProfileScreen())),
    
    // Creation screens - These use go() instead of pop() to ensure a safe return
    GoRoute(path: '/teacher-create-lesson', builder: (context, state) => const TeacherCreateLessonScreen()),
    GoRoute(path: '/teacher-create-assignment', builder: (context, state) => const TeacherCreateAssignmentScreen()),
    GoRoute(path: '/teacher-student-detail', builder: (context, state) => TeacherStudentProfileScreen(student: state.extra as Student)),
  ],
);