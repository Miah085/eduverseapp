import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:eduverse/students/utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  final bool isTeacher;
  final Function(String) onLogin;
  final VoidCallback onNavigateToRegister;

  const LoginScreen({super.key, required this.isTeacher, required this.onLogin, required this.onNavigateToRegister});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.isTeacher ? Colors.indigo : AppColors.primary;
    final bgGradient = widget.isTeacher 
        ? [Colors.white, const Color(0xFFE0E7FF)] 
        : [AppColors.white, AppColors.accentLavender];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: bgGradient),
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
                        image: NetworkImage('https://images.unsplash.com/photo-1758521541622-d1e6be8c39bb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080'),
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
                        colors: [Colors.transparent, AppColors.white.withOpacity(0.5), AppColors.white],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(24)),
                        child: Center(child: Icon(widget.isTeacher ? Icons.assignment_ind : Icons.school, size: 40, color: Colors.white)),
                      ),
                      const SizedBox(height: 16),
                      Text(widget.isTeacher ? 'Teacher Portal' : 'Welcome Back!', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.gray800)),
                      const SizedBox(height: 40),
                      _buildInput(_emailController, 'Email', Icons.mail_outline),
                      const SizedBox(height: 20),
                      _buildInput(_passwordController, 'Password', Icons.lock_outline, isPass: !_showPassword, 
                        suffix: IconButton(
                          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off, color: AppColors.gray400),
                          onPressed: () => setState(() => _showPassword = !_showPassword),
                        )),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity, height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 8),
                          child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Sign In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: widget.onNavigateToRegister,
                        child: Text("Don't have an account? Sign Up", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (response.user != null) widget.onLogin(response.user!.email!);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message), backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildInput(TextEditingController ctrl, String hint, IconData icon, {bool isPass = false, Widget? suffix}) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gray200)),
      child: TextField(
        controller: ctrl, obscureText: isPass,
        decoration: InputDecoration(hintText: hint, prefixIcon: Icon(icon, color: AppColors.gray400), suffixIcon: suffix, border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20)),
      ),
    );
  }
}