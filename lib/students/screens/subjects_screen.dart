import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
// IMPORT THE NEW SCREEN
import 'subject_detail_screen.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = [
      {
        'name': 'Science',
        'modules': 8,
        'progress': 0.65,
        'color':
            const LinearGradient(colors: [AppColors.cyan, AppColors.cyanDark]),
        'icon': Icons.science,
        'image':
            'https://images.unsplash.com/photo-1676293107432-1b6753581201?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzY2llbmNlJTIwbGFib3JhdG9yeSUyMGV4cGVyaW1lbnQlMjBjb2xvcmZ1bHxlbnwxfHx8fDE3NzAzMzIzMzh8MA&ixlib=rb-4.1.0&q=80&w=1080',
      },
      {
        'name': 'History',
        'modules': 12,
        'progress': 0.75,
        'color': const LinearGradient(
            colors: [AppColors.purple, AppColors.purpleDark]),
        'icon': Icons.public,
        'image':
            'https://images.unsplash.com/photo-1764706166195-cccf1238d510?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhbmNpZW50JTIwZWd5cHQlMjBweXJhbWlkcyUyMG11c2V1bXxlbnwxfHx8fDE3NzAzMzIzMzl8MA&ixlib=rb-4.1.0&q=80&w=1080',
      },
      {
        'name': 'Mathematics',
        'modules': 10,
        'progress': 0.45,
        'color': const LinearGradient(
            colors: [AppColors.orange, AppColors.orangeDark]),
        'icon': Icons.calculate,
        'image':
            'https://images.unsplash.com/photo-1657523070150-44b4c1ea62fe?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtYXRoZW1hdGljcyUyMGdlb21ldHJ5JTIwY29sb3JmdWx8ZW58MXx8fHwxNzcwMzMyMzQwfDA&ixlib=rb-4.1.0&q=80&w=1080',
      },
      {
        'name': 'Literature',
        'modules': 15,
        'progress': 0.80,
        'color':
            const LinearGradient(colors: [AppColors.pink, AppColors.pinkDark]),
        'icon': Icons.menu_book,
        'image':
            'https://images.unsplash.com/photo-1585742162711-ed1a0fb549ac?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxib29rcyUyMGxpYnJhcnklMjBsaXRlcmF0dXJlJTIwcmVhZGluZ3xlbnwxfHx8fDE3NzAzMzIzNDB8MA&ixlib=rb-4.1.0&q=80&w=1080',
      },
      {
        'name': 'Art & Design',
        'modules': 6,
        'progress': 0.30,
        'color': const LinearGradient(
            colors: [AppColors.green, AppColors.greenDark]),
        'icon': Icons.palette,
        'image':
            'https://images.unsplash.com/photo-1669858873972-34e68ab79aaf?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhcnQlMjBwYWludCUyMHBhbGV0dGUlMjBjcmVhdGl2ZXxlbnwxfHx8fDE3NzAzMzIzNDF8MA&ixlib=rb-4.1.0&q=80&w=1080',
      },
      {
        'name': 'Music',
        'modules': 9,
        'progress': 0.55,
        'color':
            const LinearGradient(colors: [AppColors.red, AppColors.redDark]),
        'icon': Icons.music_note,
        'image':
            'https://images.unsplash.com/photo-1609255386725-b9b6a8ad829c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtdXNpYyUyMGluc3RydW1lbnRzJTIwaGVhZHBob25lc3xlbnwxfHx8fDE3NzAzMzIzNDJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.white, AppColors.gray50],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 4,
                          offset: Offset(0, 1))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('My Subjects',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gray800)),
                    const SizedBox(height: 4),
                    const Text('Choose a subject to explore',
                        style:
                            TextStyle(fontSize: 16, color: AppColors.gray600)),
                  ],
                ),
              ),

              // Progress Card
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryLight]),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Overall Progress',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildProgressStat('6', 'Active Subjects'),
                          _buildProgressStat('60', 'Total Modules'),
                          _buildProgressStat('58%', 'Avg Progress'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Subject List
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 96),
                child: Column(
                  children: subjects.map((subject) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            // ----------------------------------------------------------------
                            // UPDATED: Navigation logic added here
                            // ----------------------------------------------------------------
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubjectDetailScreen(
                                    subjectName: subject['name'] as String,
                                    image: subject['image'] as String,
                                    moduleCount: subject['modules'] as int,
                                    duration:
                                        "12.5 Hours", // Example static data
                                    progress: subject['progress'] as double,
                                  ),
                                ),
                              );
                            },
                            // ----------------------------------------------------------------
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 64,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                subject['image'] as String),
                                            fit: BoxFit.cover,
                                            opacity: 0.3,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 64,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          gradient: subject['color']
                                              as LinearGradient,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                                color: AppColors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2))
                                          ],
                                        ),
                                        child: Icon(subject['icon'] as IconData,
                                            size: 32,
                                            color: AppColors.white
                                                .withOpacity(0.9)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(subject['name'] as String,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.gray800)),
                                        const SizedBox(height: 4),
                                        Text(
                                            '${subject['modules']} modules available',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.gray600)),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 8,
                                                decoration: BoxDecoration(
                                                    color: AppColors.gray100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: FractionallySizedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  widthFactor:
                                                      subject['progress']
                                                          as double,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      gradient: subject['color']
                                                          as LinearGradient,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                                '${((subject['progress'] as double) * 100).toInt()}%',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.gray700)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStat(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white)),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 14, color: AppColors.white.withOpacity(0.8)),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
