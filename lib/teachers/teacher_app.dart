import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme/app_theme.dart';
import 'models/student.dart';
import 'widgets/main_layout.dart';
import 'screens/teacher_dashboard_screen.dart';
import 'screens/teacher_modules_screen.dart';
import 'screens/teacher_create_lesson_screen.dart';
import 'screens/teacher_students_screen.dart';
import 'screens/teacher_student_profile_screen.dart';
import 'screens/teacher_create_assignment_screen.dart';
import 'screens/teacher_vr_management_screen.dart';
import 'screens/teacher_profile_screen.dart';

void main() {
  runApp(const EduVerseTeacherApp());
}

class EduVerseTeacherApp extends StatelessWidget {
  const EduVerseTeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EduVerse Teacher',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainLayout(
        currentIndex: 0,
        child: TeacherDashboardScreen(),
      ),
    ),
    GoRoute(
      path: '/teacher-modules',
      builder: (context, state) => const MainLayout(
        currentIndex: 1,
        child: TeacherModulesScreen(),
      ),
    ),
    GoRoute(
      path: '/teacher-create-lesson',
      builder: (context, state) => const TeacherCreateLessonScreen(),
    ),
    GoRoute(
      path: '/teacher-students',
      builder: (context, state) => const MainLayout(
        currentIndex: 2,
        child: TeacherStudentsScreen(),
      ),
    ),
    GoRoute(
      path: '/teacher-student-profile',
      builder: (context, state) {
        final student = state.extra as Student;
        return TeacherStudentProfileScreen(student: student);
      },
    ),
    GoRoute(
      path: '/teacher-create-assignment',
      builder: (context, state) => const TeacherCreateAssignmentScreen(),
    ),
    GoRoute(
      path: '/teacher-vr-management',
      builder: (context, state) => const MainLayout(
        currentIndex: 3,
        child: TeacherVRManagementScreen(),
      ),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const TeacherProfileScreen(),
    ),
  ],
);