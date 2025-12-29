import 'signup_page.dart';
import 'forgot_password_page.dart';
import 'package:flutter/material.dart';
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
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "I am a",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  _buildUserToggle(),
                  const SizedBox(height: 25),
                  
                  const Text("Email or Phone", 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  _buildTextField(hint: "juan@example.com or 09171234567"),
                  
                  const SizedBox(height: 20),
                  
                  const Text("Password", 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  _buildPasswordField(),
                  
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      // --- CONNECTED TO FORGOT PASSWORD ---
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(
                              userRole: _selectedUserType == 1 ? "Vendor" : "Customer",
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: HomePage.primaryOrange, fontSize: 13),
                      ),
                    ),
                  ),
                  
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: const BoxDecoration(
        color: HomePage.primaryOrange,
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
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    SizedBox(width: 5),
                    Text("Back", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lunch_dining, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Log in to continue",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
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
            color: isSelected ? const Color(0xFFFFF3E0) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? HomePage.primaryOrange : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected)
                const Icon(Icons.circle, size: 8, color: Colors.black),
              if (isSelected) const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          hintText: "Enter your password",
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFB886), 
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text(
          "Log In",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: TextStyle(color: Colors.black54)),
        GestureDetector(
          // --- CONNECTED TO SIGN UP ---
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: HomePage.primaryOrange, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}