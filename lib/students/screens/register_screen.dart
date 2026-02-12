import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:eduverse/students/utils/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onRegister;
  final Function(bool) onNavigateToLogin;

  const RegisterScreen({
    super.key,
    required this.onRegister,
    required this.onNavigateToLogin,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _accessCodeController = TextEditingController();

  String _selectedRole = 'student';
  bool _isLoading = false;
  bool _showPassword = false;
  final String _teacherSecretKey = "EDU2026";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _accessCodeController.dispose();
    super.dispose();
  }

Future<void> _register() async {
  // 1. Teacher Code Validation
  if (_selectedRole == 'teacher' && _accessCodeController.text.trim() != _teacherSecretKey) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid Teacher Access Code!'), backgroundColor: Colors.red),
    );
    return;
  }

  setState(() => _isLoading = true);
  
  try {
    // 2. Auth Sign Up with Metadata
    // The 'data' map is what the SQL Trigger uses to populate your profiles table
    final authResponse = await Supabase.instance.client.auth.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      data: {
        'full_name': _nameController.text.trim(),
        'role': _selectedRole, // 'teacher' or 'student'
      },
    );

    if (authResponse.user != null) {
      // 3. LOGOUT IMMEDIATELY
      // This stops auto-login and lets the user sign in properly through the correct portal
      await Supabase.instance.client.auth.signOut();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created as $_selectedRole! Please sign in.')),
        );
        // 4. Redirect to the Indigo or Lavender login page
        widget.onNavigateToLogin(_selectedRole == 'teacher');
      }
    }
  } on AuthException catch (e) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message), backgroundColor: Colors.red)
    );
  } finally {
    if (mounted) setState(() => _isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              // Header Image Stack
              Stack(
                children: [
                  Container(
                    height: 160,
                    decoration: const BoxDecoration(
                      color: AppColors.gray200,
                      image: DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1758521541622-d1e6be8c39bb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 160,
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
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(24)),
                        child: const Center(child: Text('E', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.white))),
                      ),
                      const SizedBox(height: 16),
                      const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.gray800)),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _roleBtn('student', 'Student', Icons.school),
                          const SizedBox(width: 12),
                          _roleBtn('teacher', 'Teacher', Icons.person_pin),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildInput(_nameController, 'Full Name', Icons.person_outline),
                      const SizedBox(height: 16),
                      _buildInput(_emailController, 'Email Address', Icons.mail_outline),
                      const SizedBox(height: 16),
                      _buildInput(
                        _passwordController, 
                        'Password', 
                        Icons.lock_outline, 
                        isPass: !_showPassword,
                        suffix: IconButton(
                          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off, color: AppColors.gray400),
                          onPressed: () => setState(() => _showPassword = !_showPassword),
                        ),
                      ),
                      if (_selectedRole == 'teacher') ...[
                        const SizedBox(height: 16),
                        _buildInput(_accessCodeController, 'Teacher Access Code', Icons.admin_panel_settings, isPass: true),
                      ],
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity, height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 8,
                          ),
                          child: _isLoading 
                            ? const CircularProgressIndicator(color: Colors.white) 
                            : const Text('Create Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () => widget.onNavigateToLogin(_selectedRole == 'teacher'),
                        child: const Text('Already have an account? Sign In', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 40), 
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

  Widget _roleBtn(String role, String label, IconData icon) {
    bool active = _selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedRole = role),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: active ? AppColors.primary : AppColors.gray200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: active ? Colors.white : AppColors.gray600, size: 20),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: active ? Colors.white : AppColors.gray600, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController ctrl, String hint, IconData icon, {bool isPass = false, Widget? suffix}) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gray200)),
      child: TextField(
        controller: ctrl, obscureText: isPass,
        decoration: InputDecoration(
          hintText: hint, prefixIcon: Icon(icon, color: AppColors.gray400), suffixIcon: suffix,
          border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        ),
      ),
    );
  }
}