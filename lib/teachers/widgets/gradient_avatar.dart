import 'package:flutter/material.dart';

class GradientAvatar extends StatelessWidget {
  final String text;
  final double size;
  final List<Color>? colors;
  
  const GradientAvatar({
    super.key,
    required this.text,
    this.size = 40,
    this.colors,
  });
  
  @override
  Widget build(BuildContext context) {
    final defaultColors = [
      const Color(0xFF5B7FE3),
      const Color(0xFF8B5CF6),
    ];
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors ?? defaultColors,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.4,
          ),
        ),
      ),
    );
  }
}