import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/animated_card.dart';

enum VRSessionStatus { active, scheduled, completed }

class VRSession {
  final int id;
  final String topic;
  final String subject;
  final String module;
  final String environment;
  final int duration;
  final VRSessionStatus status;
  final int joinedStudents;
  final int totalStudents;
  final String? startTime;
  
  VRSession({
    required this.id,
    required this.topic,
    required this.subject,
    required this.module,
    required this.environment,
    required this.duration,
    required this.status,
    required this.joinedStudents,
    required this.totalStudents,
    this.startTime,
  });
}

class VREnvironment {
  final int id;
  final String name;
  final String category;
  final String icon;
  
  VREnvironment({
    required this.id,
    required this.name,
    required this.category,
    required this.icon,
  });
}

class TeacherVRManagementScreen extends StatefulWidget {
  const TeacherVRManagementScreen({super.key});
  
  @override
  State<TeacherVRManagementScreen> createState() =>
      _TeacherVRManagementScreenState();
}

class _TeacherVRManagementScreenState extends State<TeacherVRManagementScreen> {
  bool showCreateSession = false;
  String selectedEnvironment = '';
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  String selectedSubject = 'Ancient History';
  String selectedModule = 'Ancient Greece';
  
  final List<VRSession> activeSessions = [
    VRSession(
      id: 1,
      topic: 'Ancient Greece Architecture',
      subject: 'Ancient History',
      module: 'Ancient Greece',
      environment: 'Parthenon Temple',
      duration: 45,
      status: VRSessionStatus.active,
      joinedStudents: 18,
      totalStudents: 42,
      startTime: '2:30 PM',
    ),
  ];
  
  final List<VRSession> scheduledSessions = [
    VRSession(
      id: 2,
      topic: 'Roman Colosseum Exploration',
      subject: 'Ancient History',
      module: 'Roman Empire',
      environment: 'Roman Colosseum',
      duration: 60,
      status: VRSessionStatus.scheduled,
      joinedStudents: 0,
      totalStudents: 42,
      startTime: '4:00 PM',
    ),
  ];
  
  final List<VREnvironment> vrEnvironments = [
    VREnvironment(
      id: 1,
      name: 'Parthenon Temple',
      category: 'Ancient Greece',
      icon: '🏛️',
    ),
    VREnvironment(
      id: 2,
      name: 'Roman Colosseum',
      category: 'Roman Empire',
      icon: '🏟️',
    ),
    VREnvironment(
      id: 3,
      name: 'Egyptian Pyramids',
      category: 'Ancient Egypt',
      icon: '🔺',
    ),
    VREnvironment(
      id: 4,
      name: 'Science Laboratory',
      category: 'Science',
      icon: '🔬',
    ),
    VREnvironment(
      id: 5,
      name: 'Space Station',
      category: 'Astronomy',
      icon: '🚀',
    ),
    VREnvironment(
      id: 6,
      name: 'Renaissance Gallery',
      category: 'Art History',
      icon: '🎨',
    ),
  ];
  
  @override
  void dispose() {
    _topicController.dispose();
    _durationController.dispose();
    super.dispose();
  }
  
  void _createSession() {
    setState(() {
      showCreateSession = false;
      _topicController.clear();
      _durationController.clear();
      selectedEnvironment = '';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Virtual session created successfully!'),
        backgroundColor: AppColors.success,
      ),
    );
  }
  
  void _endSession(int sessionId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Session $sessionId ended successfully!'),
        backgroundColor: AppColors.success,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final hasActiveSessions = activeSessions.isNotEmpty;
    final hasScheduledSessions = scheduledSessions.isNotEmpty;
    final hasAnySessions = hasActiveSessions || hasScheduledSessions;
    
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: hasAnySessions
                        ? ListView(
                            padding: const EdgeInsets.all(24),
                            children: [
                              if (hasActiveSessions) ...[
                                Text('Active Sessions', style: AppTextStyles.h4),
                                const SizedBox(height: 16),
                                ...activeSessions
                                    .asMap()
                                    .entries
                                    .map((e) => _buildActiveSessionCard(e.value, e.key)),
                                const SizedBox(height: 24),
                              ],
                              if (hasScheduledSessions) ...[
                                Text('Scheduled Sessions', style: AppTextStyles.h4),
                                const SizedBox(height: 16),
                                ...scheduledSessions
                                    .asMap()
                                    .entries
                                    .map((e) => _buildScheduledSessionCard(e.value, e.key)),
                              ],
                            ],
                          )
                        : _buildEmptyState(),
                  ),
                ],
              ),
            ),
          ),
          
          // Create Session Modal
          if (showCreateSession) _buildCreateSessionModal(),
        ],
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
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
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VR Sessions',
                        style: AppTextStyles.h3.copyWith(color: Colors.white),
                      ),
                      Text(
                        'Manage virtual learning environments',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => showCreateSession = true);
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      LucideIcons.plus,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Session Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              LucideIcons.play,
                              color: AppColors.success,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Active Sessions',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${activeSessions.length}',
                          style: AppTextStyles.h2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              LucideIcons.clock,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Scheduled',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${scheduledSessions.length}',
                          style: AppTextStyles.h2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: -0.2, end: 0);
  }
  
  Widget _buildActiveSessionCard(VRSession session, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AnimatedCard(
        delay: (100 + index * 50).ms,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.success, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    )
                        .animate(onPlay: (controller) => controller.repeat())
                        .fadeIn(duration: 800.ms)
                        .then()
                        .fadeOut(duration: 800.ms),
                    const SizedBox(width: 8),
                    Text(
                      'LIVE NOW',
                      style: AppTextStyles.overline.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      LucideIcons.globe,
                      color: AppColors.success,
                      size: 32,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(session.topic, style: AppTextStyles.h4),
                Text(
                  session.module,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              LucideIcons.users,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${session.joinedStudents}/${session.totalStudents}',
                              style: AppTextStyles.h4,
                            ),
                            Text(
                              'Students Joined',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.purpleLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              LucideIcons.clock,
                              color: AppColors.purple,
                              size: 20,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${session.duration} min',
                              style: AppTextStyles.h4,
                            ),
                            Text(
                              'Duration',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.gray50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.target,
                        color: AppColors.gray600,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Environment: ${session.environment}',
                        style: AppTextStyles.labelMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(LucideIcons.eye, size: 16),
                        label: const Text('Monitor'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryLight,
                          foregroundColor: AppColors.primary,
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _endSession(session.id),
                        icon: const Icon(LucideIcons.square, size: 16),
                        label: const Text('End'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.errorLight,
                          foregroundColor: AppColors.error,
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildScheduledSessionCard(VRSession session, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AnimatedCard(
        delay: (100 + index * 50).ms,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  LucideIcons.clock,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Starts at ${session.startTime}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(session.topic, style: AppTextStyles.h4),
            Text(
              session.module,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.gray600,
              ),
            ),
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.gray50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Environment: ${session.environment}',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Duration: ${session.duration} minutes',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.play),
              label: const Text('Start Session'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 44),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.globe,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text('No Active Sessions', style: AppTextStyles.h4),
            const SizedBox(height: 8),
            Text(
              'Create a new virtual session to get started',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.gray600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() => showCreateSession = true);
              },
              icon: const Icon(LucideIcons.plus),
              label: const Text('Create Session'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCreateSessionModal() {
    return Stack(
      children: [
        // Backdrop
        GestureDetector(
          onTap: () {
            setState(() => showCreateSession = false);
          },
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        )
            .animate()
            .fadeIn(duration: 200.ms),
        
        // Modal
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SafeArea(
              top: false,
              child: ListView(
                padding: const EdgeInsets.all(24),
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Create VR Session', style: AppTextStyles.h2),
                      GestureDetector(
                        onTap: () {
                          setState(() => showCreateSession = false);
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.gray100,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Subject
                  Text('Subject', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedSubject,
                    items: ['Ancient History', 'Science', 'Art History', 'Astronomy']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (value) {
                      setState(() => selectedSubject = value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Module
                  Text('Module', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedModule,
                    items: ['Ancient Greece', 'Roman Empire', 'Ancient Egypt']
                        .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                    onChanged: (value) {
                      setState(() => selectedModule = value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Topic
                  Text('Session Topic', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _topicController,
                    decoration: const InputDecoration(
                      hintText: 'E.g., Greek Architecture Exploration',
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Environment
                  Text('Virtual Environment', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: vrEnvironments.length,
                    itemBuilder: (context, index) {
                      final env = vrEnvironments[index];
                      final isSelected = selectedEnvironment == env.name;
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedEnvironment = env.name);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primaryLight : Colors.white,
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.gray200,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                env.icon,
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                env.name,
                                style: AppTextStyles.labelSmall,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                env.category,
                                style: AppTextStyles.caption,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Duration
                  Text('Duration (minutes)', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '45',
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() => showCreateSession = false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gray100,
                            foregroundColor: AppColors.gray700,
                            elevation: 0,
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _createSession,
                          icon: const Icon(LucideIcons.play),
                          label: const Text('Create & Start'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
            .animate()
            .slideY(begin: 0.5, end: 0, duration: 300.ms, curve: Curves.easeOut),
      ],
    );
  }
}