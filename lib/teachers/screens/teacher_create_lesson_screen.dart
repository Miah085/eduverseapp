import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/animated_card.dart';
import 'package:go_router/go_router.dart';

class TeacherCreateLessonScreen extends StatefulWidget {
  const TeacherCreateLessonScreen({super.key});
  
  @override
  State<TeacherCreateLessonScreen> createState() =>
      _TeacherCreateLessonScreenState();
}

class _TeacherCreateLessonScreenState extends State<TeacherCreateLessonScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  
  String selectedModule = 'Introduction to Ancient Civilizations';
  List<String> uploadedFiles = [];
  bool isAvailableImmediately = false;
  bool allowDownload = false;
  
  final List<String> modules = [
    'Introduction to Ancient Civilizations',
    'The Renaissance Period',
    'World War II Analysis',
  ];
  
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _durationController.dispose();
    super.dispose();
  }
  
  Future<void> _pickFile(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type == 'Image' ? FileType.image : FileType.video,
    );
    
    if (result != null) {
      setState(() {
        uploadedFiles.add(result.files.first.name);
      });
    }
  }
  
  void _removeFile(int index) {
    setState(() {
      uploadedFiles.removeAt(index);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    _buildModuleSelection(),
                    const SizedBox(height: 20),
                    _buildLessonTitle(),
                    const SizedBox(height: 20),
                    _buildLessonContent(),
                    const SizedBox(height: 20),
                    _buildMediaUpload(),
                    const SizedBox(height: 20),
                    _buildSettings(),
                    const SizedBox(height: 100), // Space for bottom buttons
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildActionButtons(),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.arrowLeft,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Create Lesson',
                style: AppTextStyles.h3.copyWith(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.eye, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Preview',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: -0.2, end: 0);
  }
  
  Widget _buildModuleSelection() {
    return AnimatedCard(
      delay: 100.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Module', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: selectedModule,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.gray50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.gray200, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.gray200, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
            ),
            items: modules.map((module) {
              return DropdownMenuItem(
                value: module,
                child: Text(module, style: AppTextStyles.bodyMedium),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedModule = value!;
              });
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildLessonTitle() {
    return AnimatedCard(
      delay: 200.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lesson Title', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Enter lesson title...',
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLessonContent() {
    return AnimatedCard(
      delay: 300.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lesson Content', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          
          // Formatting toolbar
          Row(
            children: [
              _buildFormatButton(Icons.format_bold, 'B'),
              const SizedBox(width: 8),
              _buildFormatButton(Icons.format_italic, 'I'),
              const SizedBox(width: 8),
              _buildFormatButton(Icons.format_size, 'H'),
              const SizedBox(width: 8),
              _buildFormatButton(Icons.format_list_bulleted, '•'),
            ],
          ),
          const SizedBox(height: 12),
          
          TextField(
            controller: _contentController,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: 'Write your lesson content here...',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Use the toolbar above to format your text',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
  
  Widget _buildFormatButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: label == 'B' || label == 'I' || label == 'H'
          ? Text(
              label,
              style: TextStyle(
                fontWeight: label == 'B' ? FontWeight.bold : FontWeight.normal,
                fontStyle: label == 'I' ? FontStyle.italic : FontStyle.normal,
                color: AppColors.gray700,
              ),
            )
          : Text(label, style: AppTextStyles.bodyMedium),
    );
  }
  
  Widget _buildMediaUpload() {
    return AnimatedCard(
      delay: 400.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Media Attachments', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildUploadButton(
                  icon: LucideIcons.image,
                  title: 'Upload Image',
                  subtitle: 'JPG, PNG',
                  onTap: () => _pickFile('Image'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildUploadButton(
                  icon: LucideIcons.video,
                  title: 'Upload Video',
                  subtitle: 'MP4, MOV',
                  onTap: () => _pickFile('Video'),
                ),
              ),
            ],
          ),
          
          if (uploadedFiles.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Uploaded Files:', style: AppTextStyles.labelMedium),
            const SizedBox(height: 8),
            ...uploadedFiles.asMap().entries.map((entry) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  border: Border.all(color: AppColors.success.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      LucideIcons.upload,
                      color: AppColors.success,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _removeFile(entry.key),
                      child: Text(
                        'Remove',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
  
  Widget _buildUploadButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.gray300,
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.gray400, size: 32),
            const SizedBox(height: 8),
            Text(title, style: AppTextStyles.labelMedium),
            Text(subtitle, style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSettings() {
    return AnimatedCard(
      delay: 500.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          
          Text(
            'Estimated Duration (minutes)',
            style: AppTextStyles.labelMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _durationController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: '30',
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            value: isAvailableImmediately,
            onChanged: (value) {
              setState(() {
                isAvailableImmediately = value!;
              });
            },
            title: Text(
              'Make this lesson available immediately',
              style: AppTextStyles.bodySmall,
            ),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.primary,
          ),
          
          CheckboxListTile(
            value: allowDownload,
            onChanged: (value) {
              setState(() {
                allowDownload = value!;
              });
            },
            title: Text(
              'Allow students to download materials',
              style: AppTextStyles.bodySmall,
            ),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.gray200),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gray100,
                  foregroundColor: AppColors.gray700,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Save and publish logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lesson saved successfully!'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                  context.pop();
                },
                icon: const Icon(LucideIcons.save),
                label: const Text('Save & Publish'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

