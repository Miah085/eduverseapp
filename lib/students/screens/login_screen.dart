import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  final Function(String) onLogin;
  final VoidCallback onNavigateToRegister;

  const LoginScreen(
      {super.key, required this.onLogin, required this.onNavigateToRegister});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    widget.onLogin(_emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.white, AppColors.accentLavender],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 192,
                  decoration: const BoxDecoration(
                    color: AppColors.gray200,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1758521541622-d1e6be8c39bb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoYXBweSUyMHN0dWRlbnQlMjBsZWFybmluZyUyMG9ubGluZXxlbnwxfHx8fDE3NzAyNzg5NDF8MA&ixlib=rb-4.1.0&q=80&w=1080'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 192,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.white.withOpacity(0.5),
                        AppColors.white
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 32,
                  right: 32,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -10 * _animationController.value),
                        child: Transform.rotate(
                          angle: _animationController.value * 6.28,
                          child: const Icon(Icons.auto_awesome,
                              size: 32, color: AppColors.orange),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: const Center(
                          child: Text('E',
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white))),
                    ),
                    const SizedBox(height: 16),
                    const Text('Welcome Back!',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gray800)),
                    const SizedBox(height: 8),
                    const Text('Sign in to continue learning',
                        style:
                            TextStyle(fontSize: 16, color: AppColors.gray600)),
                    const SizedBox(height: 48),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 4, bottom: 8),
                          child: Text('Email Address',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.gray700)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.gray200),
                          ),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'student@eduverse.com',
                              hintStyle: TextStyle(color: AppColors.gray400),
                              prefixIcon: Icon(Icons.mail_outline,
                                  color: AppColors.gray400),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 4, bottom: 8),
                          child: Text('Password',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.gray700)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.gray200),
                          ),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              hintStyle:
                                  const TextStyle(color: AppColors.gray400),
                              prefixIcon: const Icon(Icons.lock_outline,
                                  color: AppColors.gray400),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _showPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColors.gray400),
                                onPressed: () => setState(
                                    () => _showPassword = !_showPassword),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text('Forgot Password?',
                                  style: TextStyle(
                                      fontSize: 14, color: AppColors.primary))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 8,
                          shadowColor: AppColors.primary.withOpacity(0.3),
                        ),
                        child: const Text('Sign In',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(color: AppColors.gray200)),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('or',
                                style: TextStyle(
                                    fontSize: 14, color: AppColors.gray500))),
                        const Expanded(
                            child: Divider(color: AppColors.gray200)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? ",
                            style: TextStyle(
                                fontSize: 14, color: AppColors.gray600)),
                        TextButton(
                          onPressed: widget.onNavigateToRegister,
                          child: const Text('Create Account',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
