import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF5B7FE3);
  static const Color primaryLight = Color(0xFFE3F2FD);
  static const Color primaryDark = Color(0xFF4A6FD3);
  
  // Secondary Colors
  static const Color purple = Color(0xFF8B5CF6);
  static const Color purpleLight = Color(0xFFF3F0FF);
  
  static const Color cyan = Color(0xFF06B6D4);
  static const Color orange = Color(0xFFF59E0B);
  static const Color yellow = Color(0xFFFFF5CC);
  
  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  
  // Gradients
  static const List<Color> primaryGradient = [
    Color(0xFF5B7FE3),
    Color(0xFF8B5CF6),
  ];
  
  static const List<Color> successGradient = [
    Color(0xFF10B981),
    Color(0xFF06B6D4),
  ];
  
  static const List<Color> warningGradient = [
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
  ];
  
  static const List<Color> cyanGradient = [
    Color(0xFF06B6D4),
    Color(0xFF5B7FE3),
  ];
  static const Color gray300 = Color(0xFFD1D5DB);
  // Background Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.white,
      Color(0xFFF3F0FF),
      Color(0xFFE3F2FD),
    ],
    stops: [0.0, 0.5, 1.0],
  );
}