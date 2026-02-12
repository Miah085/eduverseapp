import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'vr_entry_screen.dart'; // Make sure you have your VREntryScreen file imported here

class ModuleDetailScreen extends StatelessWidget {
  final String moduleName;
  final VoidCallback onBack;

  const ModuleDetailScreen({
    super.key,
    required this.moduleName,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: onBack,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // --- Header Icon (Matches the Figma design) ---
              Center(
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: Stack(
                    children: [
                      // Main Blue Box
                      Container(
                        width: 140,
                        height: 140,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF818CF8), // Periwinkle Blue
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF818CF8).withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(Icons.language,
                              size: 70, color: Colors.white),
                        ),
                      ),
                      // Top Right Sparkle Chip
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD54F), // Yellow
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.auto_awesome,
                              color: Colors.white, size: 20),
                        ),
                      ),
                      // Bottom Left Eye Chip
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.remove_red_eye,
                              color: Color(0xFF818CF8), size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // --- Title & Subtitle ---
              Text(
                moduleName, // Displays the name of the clicked module
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Step into ancient Egypt and explore',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),

              // --- Quick Tips Card ---
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB), // Very light grey
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.auto_awesome,
                            size: 18, color: Color(0xFF818CF8)),
                        SizedBox(width: 8),
                        Text(
                          'Quick Tips',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTipRow(
                        Icons.remove_red_eye, 'Use gaze controls to navigate'),
                    const SizedBox(height: 16),
                    _buildTipRow(
                        Icons.volume_up, 'Audio guides available throughout'),
                    const SizedBox(height: 16),
                    _buildTipRow(
                        Icons.touch_app, 'Interactive elements will glow'),
                  ],
                ),
              ),

              const Spacer(),

              // --- Action Button ---
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to VREntryScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VREntryScreen(
                          onBack: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF818CF8), // Matches header icon
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF818CF8).withOpacity(0.4),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter Virtual Space',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'This is a safe, educational virtual environment',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF818CF8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
