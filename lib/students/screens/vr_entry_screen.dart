import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../utils/app_colors.dart';

class VREntryScreen extends StatefulWidget {
  final VoidCallback onBack;

  const VREntryScreen({super.key, required this.onBack});

  @override
  State<VREntryScreen> createState() => _VREntryScreenState();
}

class _VREntryScreenState extends State<VREntryScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotateController;
  late AnimationController _headerController;
  late List<AnimationController> _cardControllers;
  late List<AnimationController> _starControllers;

  final List<VRSpace> vrSpaces = [
    VRSpace(
      title: 'Virtual Science Lab',
      description: 'Conduct experiments safely',
      icon: Icons.science_outlined,
      color: const LinearGradient(colors: [AppColors.cyan, AppColors.cyanDark]),
      bgColor: AppColors.accentBlue,
      image:
          'https://images.unsplash.com/photo-1676293107432-1b6753581201?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzY2llbmNlJTIwbGFib3JhdG9yeSUyMGV4cGVyaW1lbnQlMjBjb2xvcmZ1bHxlbnwxfHx8fDE3NzAzMzIzMzh8MA&ixlib=rb-4.1.0&q=80&w=1080',
    ),
    VRSpace(
      title: 'History Museum',
      description: 'Explore ancient civilizations',
      icon: Icons.account_balance,
      color: const LinearGradient(
          colors: [AppColors.purple, AppColors.purpleDark]),
      bgColor: AppColors.accentLavender,
      image:
          'https://images.unsplash.com/photo-1764706166195-cccf1238d510?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhbmNpZW50JTIwZWd5cHQlMjBweXJhbWlkcyUyMG11c2V1bXxlbnwxfHx8fDE3NzAzMzIzMzl8MA&ixlib=rb-4.1.0&q=80&w=1080',
    ),
    VRSpace(
      title: 'Space Station',
      description: 'Learn about astronomy',
      icon: Icons.rocket_launch,
      color: const LinearGradient(
          colors: [AppColors.orange, AppColors.orangeDark]),
      bgColor: AppColors.accentYellow,
      image:
          'https://images.unsplash.com/photo-1613174635760-a78709ac1ace?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcGFjZSUyMHN0YXRpb24lMjBhc3Ryb25vbXklMjBzdGFyc3xlbnwxfHx8fDE3NzAzMzIzNDF8MA&ixlib=rb-4.1.0&q=80&w=1080',
    ),
    VRSpace(
      title: 'Tropical Ecosystem',
      description: 'Study biodiversity',
      icon: Icons.forest,
      color:
          const LinearGradient(colors: [AppColors.green, AppColors.greenDark]),
      bgColor: AppColors.greenLight,
      image:
          'https://images.unsplash.com/photo-1768138754183-822e958b446e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx0cm9waWNhbCUyMHJhaW5mb3Jlc3QlMjBuYXR1cmUlMjBlY29zeXN0ZW18ZW58MXx8fHwxNzcwMzMyMzQyfDA&ixlib=rb-4.1.0&q=80&w=1080',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _cardControllers = List.generate(
      vrSpaces.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _starControllers = List.generate(
      20,
      (index) => AnimationController(
        duration: Duration(milliseconds: 2000 + (math.Random().nextInt(2000))),
        vsync: this,
      )..repeat(reverse: true),
    );

    for (var i = 0; i < _cardControllers.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        if (mounted) _cardControllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _headerController.dispose();
    for (var controller in _cardControllers) {
      controller.dispose();
    }
    for (var controller in _starControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1E1B4B), Color(0xFF312E81)],
        ),
      ),
      child: Stack(
        children: [
          ..._buildStars(),
          SafeArea(
            child: Column(
              children: [
                FadeTransition(
                  opacity: _headerController,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.2),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _headerController,
                      curve: Curves.easeOut,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: widget.onBack,
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: AppColors.white,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Back to Home',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          RotationTransition(
                            turns: _rotateController,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primaryLight
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.5),
                                    blurRadius: 24,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.remove_red_eye_outlined,
                                size: 40,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Virtual Worlds',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Use your gaze to select a destination',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                    children: [
                      ...List.generate(vrSpaces.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildVRCard(vrSpaces[index], index),
                        );
                      }),
                      const SizedBox(height: 24),
                      _buildInfoCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStars() {
    final random = math.Random(42);
    return List.generate(20, (index) {
      final top = random.nextDouble() * 100;
      final left = random.nextDouble() * 100;

      return Positioned(
        top: MediaQuery.of(context).size.height * (top / 100),
        left: MediaQuery.of(context).size.width * (left / 100),
        child: AnimatedBuilder(
          animation: _starControllers[index],
          builder: (context, child) {
            return Opacity(
              opacity: 0.2 + (0.8 * _starControllers[index].value),
              child: Transform.scale(
                scale: 1.0 + (0.5 * _starControllers[index].value),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildVRCard(VRSpace space, int index) {
    return AnimatedBuilder(
      animation: _cardControllers[index],
      builder: (context, child) {
        return Transform.scale(
          scale: 0.9 + (0.1 * _cardControllers[index].value),
          child: Opacity(
            opacity: _cardControllers[index].value,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.white.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            image: DecorationImage(
                              image: NetworkImage(space.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              gradient: space.color,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              space.icon,
                              size: 32,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  space.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  space.description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.white.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.white.withOpacity(0.4),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.remove_red_eye_outlined,
                              size: 24,
                              color: AppColors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.white.withOpacity(0.2),
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              size: 20,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gaze-Based Navigation',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Look at any world for 2 seconds to enter. Move your head to explore the virtual environment. No controllers needed!',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white.withOpacity(0.7),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VRSpace {
  final String title;
  final String description;
  final IconData icon;
  final LinearGradient color;
  final Color bgColor;
  final String image;

  VRSpace({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.image,
  });
}
