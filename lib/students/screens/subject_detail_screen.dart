import 'package:flutter/material.dart';
import '../utils/app_colors.dart'; // Ensure this path is correct
// Import your ModulesScreen if you want to navigate further to the list of modules
import 'modules_screen.dart';

class SubjectDetailScreen extends StatelessWidget {
  final String subjectName;
  final String image;
  final int moduleCount;
  final String duration;
  final double progress;

  const SubjectDetailScreen({
    super.key,
    required this.subjectName,
    required this.image,
    required this.moduleCount,
    required this.duration,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Back Button & Chat Icon (Top Bar)
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: IconButton(
                    icon: const Icon(Icons.chat_bubble_outline,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),

          // Main Content (Scrollable Sheet)
          Positioned.fill(
            top: 220,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tag & Progress
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1), // Purple color
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.school, color: Colors.white, size: 16),
                              SizedBox(width: 6),
                              Text(
                                "EduVerse Core Curriculum",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${(progress * 100).toInt()}%",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const Text(
                              "Overall Score",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      subjectName,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // Info Row
                    Row(
                      children: [
                        _buildInfoChip(Icons.book, "$moduleCount Modules",
                            "Self-paced learning"),
                        const SizedBox(width: 16),
                        _buildInfoChip(
                            Icons.access_time, duration, "Est. completion"),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Description
                    Text(
                      "Master the fundamentals of $subjectName through immersive virtual reality experiences and teacher-guided module sequences.",
                      style: const TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    const SizedBox(height: 24),

                    // Resume Button (Navigates to ModulesScreen)
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to your existing ModulesScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModulesScreen(
                                onBack: () => Navigator.pop(context),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5CF6), // Purple
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          shadowColor: const Color(0xFF8B5CF6).withOpacity(0.4),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow),
                            SizedBox(width: 8),
                            Text(
                              "Resume Learning",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Module Collection Header
                    const Text(
                      "Module Collection",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Each module contains lessons, assignments, quizzes, and optional VR experiences.",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 20),

                    // Module List Items (Static examples based on image)
                    _buildModuleTile(
                        "Ancient Civilizations", "10 Lessons", 1.0, true),
                    const SizedBox(height: 16),
                    _buildModuleTile("Medieval Europe", "8 Lessons", 1.0, true),
                    const SizedBox(height: 16),
                    _buildModuleTile("Renaissance & Enlightenment",
                        "12 Lessons", 0.65, false),
                    const SizedBox(height: 16),
                    _buildModuleTile(
                        "Modern World History", "14 Lessons", 0.0, false,
                        isLocked: true),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String title, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF8B5CF6), size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(subtitle,
                      style: const TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleTile(
      String title, String subtitle, double progress, bool isCompleted,
      {bool isLocked = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Status Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isLocked
                  ? Colors.grey.shade100
                  : (isCompleted ? Colors.green.shade50 : Colors.blue.shade50),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isLocked
                  ? Icons.lock
                  : (isCompleted ? Icons.check : Icons.circle),
              color: isLocked
                  ? Colors.grey
                  : (isCompleted ? Colors.green : Colors.blue),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),

          // Text Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isLocked ? Colors.grey : Colors.black)),
                    if (!isLocked)
                      Text("${(progress * 100).toInt()}%",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4),

                // Progress Bar
                if (!isLocked)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          isCompleted ? Colors.green : Colors.blue),
                      minHeight: 4,
                    ),
                  ),
                if (isLocked)
                  const Text("Locked",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),

                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.book, size: 14, color: Colors.grey.shade400),
                    const SizedBox(width: 4),
                    Text(subtitle,
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          // Arrow
          if (!isLocked)
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(Icons.play_arrow, color: Color(0xFF6366F1)),
            ),
        ],
      ),
    );
  }
}
