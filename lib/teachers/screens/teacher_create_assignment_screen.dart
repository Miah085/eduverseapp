import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/animated_card.dart';
import 'package:go_router/go_router.dart';

class TeacherCreateAssignmentScreen extends StatefulWidget {
  const TeacherCreateAssignmentScreen({super.key});
  
  @override
  State<TeacherCreateAssignmentScreen> createState() =>
      _TeacherCreateAssignmentScreenState();
}

class _TeacherCreateAssignmentScreenState
    extends State<TeacherCreateAssignmentScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _externalLinkController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  
  String selectedSubject = 'Ancient History';
  String selectedModule = 'Ancient Greece';
  DateTime? selectedDueDate;
  TimeOfDay? selectedTime;
  List<String> uploadedFiles = [];
  bool allowLateSubmissions = true;
  bool requireFileSubmission = false;
  bool sendNotification = true;
  
  final List<String> subjects = [
    'Ancient History',
    'World Geography',
    'Biology',
    'Physics',
    'Literature',
  ];
  
  final List<String> modules = [
    'Ancient Greece',
    'Roman Empire',
    'Ancient Egypt',
    'Renaissance Period',
  ];
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _externalLinkController.dispose();
    _pointsController.dispose();
    super.dispose();
  }
  
  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => selectedDueDate = date);
    }
  }
  
  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => selectedTime = time);
    }
  }
  
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'jpg', 'png', 'mp4'],
    );
    
    if (result != null) {
      setState(() {
        uploadedFiles.addAll(result.files.map((f) => f.name));
      });
    }
  }
  
  void _removeFile(int index) {
    setState(() {
      uploadedFiles.removeAt(index);
    });
  }
  
  void _publishAssignment() {
    // Validation
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter assignment title'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Assignment published successfully!'),
        backgroundColor: AppColors.success,
      ),
    );
    context.pop();
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
                    _buildSubjectModuleSelection(),
                    const SizedBox(height: 20),
                    _buildAssignmentTitle(),
                    const SizedBox(height: 20),
                    _buildDescription(),
                    const SizedBox(height: 20),
                    _buildDueDateSection(),
                    const SizedBox(height: 20),
                    _buildExternalLink(),
                    const SizedBox(height: 20),
                    _buildAttachments(),
                    const SizedBox(height: 20),
                    _buildSettings(),
                    const SizedBox(height: 100),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                Text(
                  'Create Assignment',
                  style: AppTextStyles.h3.copyWith(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 52),
              child: Text(
                'Design and publish new assignments',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: -0.2, end: 0);
  }
  
  Widget _buildSubjectModuleSelection() {
    return AnimatedCard(
      delay: 100.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Assignment Details', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          
          Text('Subject', style: AppTextStyles.labelMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: selectedSubject,
            decoration: const InputDecoration(),
            items: subjects.map((subject) {
              return DropdownMenuItem(
                value: subject,
                child: Text(subject, style: AppTextStyles.bodyMedium),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => selectedSubject = value!);
            },
          ),
          const SizedBox(height: 16),
          
          Text('Module', style: AppTextStyles.labelMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: selectedModule,
            decoration: const InputDecoration(),
            items: modules.map((module) {
              return DropdownMenuItem(
                value: module,
                child: Text(module, style: AppTextStyles.bodyMedium),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => selectedModule = value!);
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildAssignmentTitle() {
    return AnimatedCard(
      delay: 200.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Assignment Title', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'E.g., Ancient Greece Essay',
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDescription() {
    return AnimatedCard(
      delay: 300.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Assignment Description', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            maxLines: 6,
            decoration: const InputDecoration(
              hintText: 'Provide clear instructions for this assignment...',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Include objectives, requirements, and grading criteria',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
  
  Widget _buildDueDateSection() {
    return AnimatedCard(
      delay: 400.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Due Date & Time', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          
          // Date Picker
          GestureDetector(
            onTap: _selectDate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.gray50,
                border: Border.all(color: AppColors.gray200, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.calendar, color: AppColors.gray400),
                  const SizedBox(width: 12),
                  Text(
                    selectedDueDate == null
                        ? 'Select date'
                        : '${selectedDueDate!.day}/${selectedDueDate!.month}/${selectedDueDate!.year}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: selectedDueDate == null
                          ? AppColors.gray400
                          : AppColors.gray800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Time Picker
          GestureDetector(
            onTap: _selectTime,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.gray50,
                border: Border.all(color: AppColors.gray200, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.clock, color: AppColors.gray400),
                  const SizedBox(width: 12),
                  Text(
                    selectedTime == null
                        ? 'Select time'
                        : selectedTime!.format(context),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: selectedTime == null
                          ? AppColors.gray400
                          : AppColors.gray800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildExternalLink() {
    return AnimatedCard(
      delay: 500.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('External Link (Optional)', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          TextField(
            controller: _externalLinkController,
            decoration: const InputDecoration(
              hintText: 'https://forms.office.com/quiz-link',
              prefixIcon: Icon(LucideIcons.link),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add links to Microsoft Forms, Google Forms, or other resources',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
  
  Widget _buildAttachments() {
    return AnimatedCard(
      delay: 600.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Attachments', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.gray300,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(
                    LucideIcons.upload,
                    color: AppColors.gray400,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Upload Assignment Files',
                    style: AppTextStyles.labelMedium,
                  ),
                  Text(
                    'PDF, DOCX, Images, Videos',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ),
          
          if (uploadedFiles.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Attached Files:', style: AppTextStyles.labelMedium),
            const SizedBox(height: 8),
            ...uploadedFiles.asMap().entries.map((entry) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      LucideIcons.fileText,
                      color: Color(0xFF2563EB),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: const Color(0xFF1E40AF),
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
  
  Widget _buildSettings() {
    return AnimatedCard(
      delay: 700.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          
          Text('Maximum Points', style: AppTextStyles.labelMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _pointsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: '100',
            ),
          ),
          const SizedBox(height: 16),
          
          CheckboxListTile(
            value: allowLateSubmissions,
            onChanged: (value) {
              setState(() => allowLateSubmissions = value!);
            },
            title: Text(
              'Allow late submissions',
              style: AppTextStyles.bodySmall,
            ),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.primary,
          ),
          
          CheckboxListTile(
            value: requireFileSubmission,
            onChanged: (value) {
              setState(() => requireFileSubmission = value!);
            },
            title: Text(
              'Require file submission',
              style: AppTextStyles.bodySmall,
            ),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.primary,
          ),
          
          CheckboxListTile(
            value: sendNotification,
            onChanged: (value) {
              setState(() => sendNotification = value!);
            },
            title: Text(
              'Send notification to students',
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
                onPressed: _publishAssignment,
                icon: const Icon(LucideIcons.save),
                label: const Text('Publish Assignment'),
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