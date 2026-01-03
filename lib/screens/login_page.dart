// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_text_field.dart';
import '../services/auth_service.dart';
import 'signup_page.dart';
import 'forgot_password_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final String initialRole;
  const LoginPage({super.key, this.initialRole = "Customer"});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late int _selectedUserType; // 0 = Customer, 1 = Vendor
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _selectedUserType = widget.initialRole == "Vendor" ? 1 : 0;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = AuthService();

      final success = await authService.login(
        _emailController.text,
        _passwordController.text,
      );

      if (success && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("I am a"),
                  const SizedBox(height: 12),
                  _buildUserToggle(),
                  const SizedBox(height: 25),
                  _buildLabel("Email or Phone"),
                  const SizedBox(height: 8),
                  AuthTextField(
                    hint: "juan@example.com or 09171234567",
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  _buildLabel("Password"),
                  const SizedBox(height: 8),
                  AuthTextField(
                    hint: "Enter your password",
                    controller: _passwordController,
                    isPassword: true,
                    obscureText: !_isPasswordVisible,
                    onToggleVisibility: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                  _buildForgotPasswordButton(),
                  const SizedBox(height: 20),
                  _buildLoginButton(),
                  const SizedBox(height: 30),
                  _buildSignUpLink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14));
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: const BoxDecoration(
        color: AppColors.primaryOrange,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    SizedBox(width: 5),
                    Text("Back", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ClipOval(
                    child: Image.asset('assets/images/bahay_kusina_logo.png', width: 60, height: 60, fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("Log in to continue", style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserToggle() {
    return Row(
      children: [
        _toggleButton("Customer", 0),
        const SizedBox(width: 15),
        _toggleButton("Vendor", 1),
      ],
    );
  }

  Widget _toggleButton(String label, int index) {
    bool isSelected = _selectedUserType == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedUserType = index),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.selectorBackground : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? AppColors.primaryOrange : const Color.fromARGB(255, 243, 241, 241), width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected) const Padding(padding: EdgeInsets.only(right: 8), child: Icon(Icons.circle, size: 8, color: Colors.black)),
              Text(label, style: TextStyle(color: Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPasswordPage(
              userRole: _selectedUserType == 1 ? "Vendor" : "Customer",
            ),
          ),
        ),
        child: const Text("Forgot Password?", style: TextStyle(color: AppColors.primaryOrange, fontSize: 13)),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : () => _handleLogin(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryOrangeLight,
          disabledBackgroundColor: Colors.grey.shade400,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : const Text("Log In", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: TextStyle(color: Colors.black54)),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage())),
          child: const Text("Sign Up", style: TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
