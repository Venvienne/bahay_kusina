import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_text_field.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedUserType = widget.initialRole == "Vendor" ? 1 : 0;
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
                  const AuthTextField(hint: "juan@example.com or 09171234567"),
                  const SizedBox(height: 20),
                  _buildLabel("Password"),
                  const SizedBox(height: 8),
                  AuthTextField(
                    hint: "Enter your password",
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

  // --- ENCAPSULATED UI COMPONENTS ---

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
          MaterialPageRoute(builder: (context) => ForgotPasswordPage(userRole: _selectedUserType == 1 ? "Vendor" : "Customer")),
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
        onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage())),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryOrangeLight,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text("Log In", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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